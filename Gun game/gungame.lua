require("Gun%20game/EventsHandler.lua")

shared.OnPlayerDiedConnection = on_player_died:Connect(function(name, killer_data, stats_counted)
	-- mostly same data the game uses
    print("-----------------")
	print(name, "died to", killer_data.typ, "by", killer_data.name) -- can be burning, drowning, firearm, grenade, map_reset, other, reset
        for i,v in killer_data do
            print(i," :",v)
        end
    print("-----------------")
end)