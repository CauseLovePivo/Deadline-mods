shared.EventsTable = {
    respawn = function(player)
        player.explode()
    end;
    get_my_stats = function(player)
        for i,v in player do
            print(i," ",v)    
        end
    end
}



on_client_event:Connect(function(plrname, args)
    local player = get_player(plrname)

    shared.EventsTable[args[1]](player)
end)
