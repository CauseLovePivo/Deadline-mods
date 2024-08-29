print("gungame, ver:0.32")
require("Gun%20game/EventsHandler.lua")
require("Gun%20game/WeaponList.lua")
--shared.OnPlayerDiedConnection:Disconnect()
shared.weaponlevels = {}


function shared.UpdateWeaponLevel(name)
    shared.weaponlevels[name] += 1

    local player = get_player(name)
    local level = shared.weaponlevels[name]
    local weaponlistData = shared.Weaponlist[level]

    local setup = get_setup_from_code(weaponlistData.code)

    if setup.status ~= "_" then
        warn("setup is not valid")
    else
        -- 1st argument is primary, secondary, throwable1, throwable2
        player.set_weapon("primary", setup.weapon, setup.data)
    end
end

shared.OnPlayerDiedConnection = on_player_died:Connect(function(name, killer_data, stats_counted) 	-- mostly same data the game uses
    print("-----------------")
	print(name, "died to", killer_data.type, "by", killer_data.name)

        local player = get_player(killer_data.name)
        shared.UpdateWeaponLevel(killer_data.name)
     
    -- can be burning, drowning, firearm, grenade, map_reset, other, reset
    print("-----------------")
end)

on_player_spawned:Connect(function(name)
    local player = get_player(name)
    if shared.weaponlevels[name] == nil then
        shared.weaponlevels[name] = 0
    end
	print(`{name} spawned, gungame level :{shared.weaponlevels[name]}`)
end)