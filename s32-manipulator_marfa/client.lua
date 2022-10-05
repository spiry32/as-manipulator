
vRP = Proxy.getInterface("vRP")

local CoordonateMarfa = {
    {-408.00643920898,6148.19921875,31.678316116333},
    {-427.96533203125,6162.5263671875,31.478052139282}
}
local incepeJob = {
    {-423.02117919922,6135.7622070312,31.877311706543}
}

local LasaCutia = {
    {-413.93267822266,6171.5610351562,31.478046417236}
}
local vinde = {
    {-132.13655090332,6351.3076171875,31.490653991699}
}
inTura = false
arecutie = false

Citizen.CreateThread(function()
    while true do 
        Wait(0)
        local ped = PlayerPedId()
        local playerCoord = GetEntityCoords(ped)
        for k,v in pairs (incepeJob) do 
            local distance = GetDistanceBetweenCoords(playerCoord.x, playerCoord.y, playerCoord.z,v[1],v[2],v[3] , true)
            if distance < 10 then
            if (Vdist(playerCoord.x, playerCoord.y, playerCoord.z,v[1],v[2],v[3])) then
                --if arejob then
                    if not inTura then
                        DrawText3Ds(-423.02117919922,6135.7622070312,31.877311706543+.5, 'Apasa ~g~[E]~w~ pentru a ~g~intra ~w~in tura')
                        else
                            DrawText3Ds(-423.02117919922,6135.7622070312,31.877311706543+.5, 'Apasa ~g~[E]~w~ pentru a ~r~iesi ~w~din tura')
                        end
                            DrawMarker(29, v[1],v[2],v[3] , 0, 0, 0, 0, 0, 0, 0.5001,0.5001,0.5001, 38, 255, 30, 200, 0, 0, 0, 1, 0, 0, 0)
                            if distance < 1 then
                                if IsControlJustPressed(0, 38) then
                                    --checkPerm()
                                    if not inTura then
                                        TriggerServerEvent("get:job")
                                        ExecuteCommand("e think")
                                        exports.rprogress:Start("Semnezi contractul de munca", 5000)
                                        ExecuteCommand("e c")
                                        inTura = true    
                                    else
                                        ExecuteCommand("e nervous")
                                        exports.rprogress:Start("Rupi contractul de munca", 5000)
                                        ExecuteCommand("e c")
                                        inTura = false
                                        TriggerServerEvent("remove:job")
                                    end 
                                end
                            end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        --if inTura then
            local ped = PlayerPedId()
            local playerCoord = GetEntityCoords(ped)
            for k,v in pairs (CoordonateMarfa) do 
                local distance = GetDistanceBetweenCoords(playerCoord.x, playerCoord.y, playerCoord.z,v[1],v[2],v[3] , true)
                if distance < 10 then
                if (Vdist(playerCoord.x, playerCoord.y, playerCoord.z,v[1],v[2],v[3])) then
                    if inTura and not arecutie then
                        DrawText3Ds(v[1],v[2],v[3]+.5, 'Apasa ~g~[E]~w~ pentru a prelua marfa')
                        DrawMarker(30, v[1],v[2],v[3] , 0, 0, 0, 0, 0, 0, 0.5001,0.5001,0.5001, 255,198,30, 200, 0, 0, 0, 1, 0, 0, 0)
                        if distance < 1 then 
                            if IsControlJustPressed(0, 38) then
                                ExecuteCommand("e mechanic")
                                exports.rprogress:Start("Colectezi marfa", 3000)
                                ExecuteCommand("e c")
                                ExecuteCommand("e box")
                                arecutie = true
                    end
                            end
                        end
                    end
                end
            end   
        --end
    end
end)


Citizen.CreateThread(function()
    while true do
        Wait(0)
            local ped = PlayerPedId()
            local playerCoord = GetEntityCoords(ped)
        for k,v in pairs (LasaCutia) do 
                local distance = GetDistanceBetweenCoords(playerCoord.x, playerCoord.y, playerCoord.z,v[1],v[2],v[3] , true)
            if distance < 10 then
                if (Vdist(playerCoord.x, playerCoord.y, playerCoord.z,v[1],v[2],v[3])) then
                    if inTura then
                        DrawText3Ds(-413.93267822266,6171.5610351562,31.478046417236+.5, 'Apasa ~g~[E]~w~ pentru a preda marfa')
                        DrawMarker(30, v[1],v[2],v[3] , 0, 0, 0, 0, 0, 0, 0.5001,0.5001,0.5001, 255,198,30, 200, 0, 0, 0, 1, 0, 0, 0)
                        if distance < 1 and arecutie then 
                            if IsControlJustPressed(0, 38) then
                                ExecuteCommand("e c")
                                ExecuteCommand("e mechanic")
                                exports.rprogress:Start("Lasi cutia", 2000)
                                ExecuteCommand("e c")
                                TriggerServerEvent("primeste:factura")
                                arecutie = false
                            end
                        end 
                    end
                end
            end
        end   
    end
end)

function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
        local blip = AddBlipForCoord(-435.58792114258,6154.4213867188,31.478054046631)
  
        SetBlipSprite (blip, 500)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.7)
        SetBlipColour (blip, 5)
        SetBlipAsShortRange(blip, true)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Vinzare Facturi')
        EndTextCommandSetBlipName(blip)
end)

