shared.EventsTable = {
    kill_player = function(player)
        player.explode()
    end;
    update_gungame_stats = function(player)
        for i,v in get_players() do
            print(i)
            shared.weaponlevels[i] = 0
        end
    end
}



on_client_event:Connect(function(plrname, args)
    local player = get_player(plrname)
    for i,v in player do
        print(i," ",v)
    end
    shared.EventsTable[args[1]](player)
end)
