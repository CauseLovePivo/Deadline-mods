print("gungame, ver:0.32")
require("Gun%20game/EventsHandler.lua")
--shared.OnPlayerDiedConnection:Disconnect()
shared.weaponlevels = {}

for i,v in get_players() do
    print(i)
    shared.weaponlevels[i] = 0
end

shared.OnPlayerDiedConnection = on_player_died:Connect(function(name, killer_data, stats_counted) 	-- mostly same data the game uses
    print("-----------------")
	print(name, "died to", killer_data.type, "by", killer_data.name)

        local player = get_player(killer_data.name)
        shared.weaponlevels[killer_data.name] += 1
     
    -- can be burning, drowning, firearm, grenade, map_reset, other, reset
end)

on_player_spawned:Connect(function(name)
    local player = get_player(name)
	print(`{name} spawned, gungame level :{shared.weaponlevels[name]}`)
end)