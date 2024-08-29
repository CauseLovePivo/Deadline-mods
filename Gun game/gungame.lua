print("gungame, ver:0.331")
require("Gun%20game/EventsHandler.lua")
require("Gun%20game/WeaponList.lua")
--shared.OnPlayerDiedConnection:Disconnect()
shared.weaponlevels = {}


function shared.UpdateWeaponFromLevel(name)
    print("hello")
    local player = get_player(name)
    local level = shared.weaponlevels[name]
    local weaponlistData = shared.Weaponlist[level]

    local setup = get_setup_from_code(weaponlistData.code)
    print(weaponlistData[0].name)
    player.set_weapon("primary", setup.weapon, setup.data)
end

shared.OnPlayerDiedConnection = on_player_died:Connect(function(name, killer_data, stats_counted) 	-- mostly same data the game uses
    print("-----------------")
	print(name, "died to", killer_data.type, "by", killer_data.name)    
    shared.weaponlevels[name] += 1
    shared.UpdateWeaponFromLevel(killer_data.name)
     
    -- can be burning, drowning, firearm, grenade, map_reset, other, reset
    print("-----------------")
end)

on_player_spawned:Connect(function(name)
    local player = get_player(name)
    if shared.weaponlevels[name] == nil then
        shared.weaponlevels[name] = 1
    end
	print(`{name} spawned, gungame level :{shared.weaponlevels[name]}`)
end)