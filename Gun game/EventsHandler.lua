shared.EventsTable = {
    kill_player = function(player)
        player.explode()
    end;
    update_gungame_stats = function(player)
        for i,v in get_players() do
            print(i)
            shared.weaponlevels[i] = 0
        end
    end;
    get_my_stats = function (player)
        for i,v in player do
            if not type(v) == table then
                print(i," ",v)
            else
                for j,v2 in v do
                    print(j2," ",v2)
                end
            end      
        end        
    end
}



on_client_event:Connect(function(plrname, args)
    local player = get_player(plrname)

    shared.EventsTable[args[1]](player)
end)
