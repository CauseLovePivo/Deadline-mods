info("gungame, ver:0.2")
require("Gun%20game/EventsHandler.lua")
require("Gun%20game/WeaponList.lua")
--shared.OnPlayerDiedConnection:Disconnect()
shared.weaponlevels = {}

local map_config = config.maps.MAP_CONFIGURATION

local MAX_LEVEL = 2

function shared.UpdateWeaponFromLevel(name)
    local player = get_player(name)
    local level = shared.weaponlevels[name]
    local weaponlistData = shared.Weaponlist[level]

    print(name,level,weaponlistData.code,weaponlistData.name)

    local setup = get_setup_from_code(weaponlistData.code)
    player.set_weapon("primary", weaponlistData.name, setup.data)
end


function shared.EndMatch(winner)
    chat.send_announcement(`{winner} won! 20s Intermission between matches...`)  
    sharedvars.sv_spawning_enabled = false
    set_spawning_disabled_reason("Intermission between matches")

    for _, player in pairs(get_alive_players()) do
        task.spawn(function()
            player.explode()
        end)
    end

    table.clear(shared.weaponlevels)

    map.set_map('template_map')
    sharedvars.sv_spawning_enabled = true
    set_spawning_disabled_reason("")
end

local OnPlayerDiedConnection = on_player_died:Connect(function(name, killer_data, stats_counted) 	-- mostly same data the game uses
    print("-----------------")
	print(name, "died to", killer_data.type, "by", killer_data.name)  -- can be burning, drowning, firearm, grenade, map_reset, other, reset
    if shared.weaponlevels[killer_data.name] + 1 > MAX_LEVEL then
        shared.EndMatch(killer_data.name)
        return
    else
        shared.weaponlevels[killer_data.name] += 1
        shared.UpdateWeaponFromLevel(killer_data.name)
    end

    print("-----------------")
end)

local OnPlayerSpawnedConnection = on_player_spawned:Connect(function(name)
    local player = get_player(name)
    if shared.weaponlevels[name] == nil then
        shared.weaponlevels[name] = 1
    end
	print(`{name} spawned, gungame level :{shared.weaponlevels[name]}`)
    shared.UpdateWeaponFromLevel(name)
end)