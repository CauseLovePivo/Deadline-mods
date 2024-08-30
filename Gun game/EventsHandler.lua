shared.EventsTable = {
    respawn = function(player)
        player.explode()
        player.spawn()
    end;
    get_my_stats = function(player)
        for i,v in player do
            print(i," ",v)    
        end
    end;

    gungame_restart = function(player)
        shared.EndMatch()
    end
}



on_client_event:Connect(function(plrname, args)
    local player = get_player(plrname)
    local event = args[1]

    if shared.EventsTable[event] == nil then
        return
    end

    table.remove(args,1)
    print(args)

    shared.EventsTable[event](player)
end)
