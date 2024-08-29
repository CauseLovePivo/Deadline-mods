print("gungame, ver:0.1")
require("Gun%20game/EventsHandler.lua")
--shared.OnPlayerDiedConnection:Disconnect()
shared.OnPlayerDiedConnection = on_player_died:Connect(function(name, killer_data, stats_counted) 	-- mostly same data the game uses
    print("-----------------")
	print(name, "died to", killer_data.type, "by", killer_data.name)

    if killer_data.name then
        local player = get_player(killer_data.name)
        player.Weaponlevel += 1
        print(player.name, "weapon level is: ", player.Weaponlevel)
    end
    
    -- can be burning, drowning, firearm, grenade, map_reset, other, reset
end)

on_player_spawned:Connect(function(name)
    local player = get_player(name)
    player.Weaponlevel = 0
	print(`{name} spawned, gungame level :{player.Weaponlevel}`)
end)