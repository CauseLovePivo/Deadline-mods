require("Gun%20game/EventsHandler.lua")

on_player_died:Connect(function(name, killer_data, stats_counted)
	-- mostly same data the game uses

	print(name, "died to", killer_data.type) -- can be burning, drowning, firearm, grenade, map_reset, other, reset
    print(killer_data)
end)