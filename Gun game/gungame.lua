require("Gun%20game/EventsHandler.lua")
require("Gun%20game/WeaponList.lua")
--shared.OnPlayerDiedConnection:Disconnect()
shared.weaponlevels = {}
local map_config = config.maps.MAP_CONFIGURATION

local MAX_LEVEL = #shared.Weaponlist

local function random_value_in_map(map)
	local entries = {}

	for key in pairs(map) do
		table.insert(entries, key)
	end

	local key = entries[math.random(1, #entries)]

	return map[key]
end


function shared.UpdateWeaponFromLevel(name)
    local player = get_player(name)
    local level = shared.weaponlevels[name]
    local weaponlistData = shared.Weaponlist[level]

    print(name,level,weaponlistData.code,weaponlistData.name)

    local setup = get_setup_from_code(weaponlistData.code)
    player.set_weapon("primary", weaponlistData.name, setup.data)
    player.refill_ammo()
end     

function shared.EndMatch(winner)
    if winner then
        chat.send_announcement(`{winner} won! 10s Intermission between matches...`) 
    else
        chat.send_announcement(`restarting in 10s...`) 
    end

    sharedvars.sv_spawning_enabled = false
    set_spawning_disabled_reason("Intermission between matches")
    
    task.delay(10,function()
        sharedvars.sv_spawning_enabled = true
        set_spawning_disabled_reason("")
    end)

    for _, player in pairs(get_alive_players()) do
        task.spawn(function()
            player.explode()
        end)
    end
    chat.send_announcement(`selecting random map...`) 
    local randomMapConfig = random_value_in_map(map_config)
    randomMapConfig.gamemode = "NONE"
    map.set_map_from_config(randomMapConfig)

   -- sharedvars.sv_spawning_enabled = true

    table.clear(shared.weaponlevels)

--    map.set_map('template_map')
end

local OnPlayerDiedConnection = on_player_died:Connect(function(name, killer_data, stats_counted) 	-- mostly same data the game uses
    print("-----------------")
	print(name, "died to", killer_data.type, "by", killer_data.name)  -- can be burning, drowning, firearm, grenade, map_reset, other, reset

    if killer_data.type ~= "firearm" or killer_data.name == name then
        return
    end

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

info("")
info("testin")