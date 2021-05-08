-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD : ! Jp#2263 | https://discord.gg/HEtBSAJuJU
-----------------------------------------------------------------------------------------------------------------------------------------

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

emp = Tunnel.getInterface('japa_maconha')

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------

local etapa = 0 
local japa = false

-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDENADAS
-----------------------------------------------------------------------------------------------------------------------------------------
local objeto = {2211.82, 5578.95, 53.74}
local blipfertilizante = {2194.14, 5593.89, 53.76} 
local blipdeixarfertiliaznte = {2211.71,5578.09,53.85} 
local plantacoes = {
    [1] = {2215.44,5577.52,53.83, fertilizado = false, colhido = false},
    [2] = {2218.02,5579.62,53.98, fertilizado = false, colhido = false},
    [3] = {2215.03,5575.36,53.69, fertilizado = false, colhido = false},
    [4] = {2217.47,5575.15,53.73, fertilizado = false, colhido = false},
    [5] = {2220.36,5574.92,53.73, fertilizado = false, colhido = false},
    [6] = {2222.05,5574.9,53.73, fertilizado = false, colhido = false},
    [7] = {2226.63,5574.55,53.8, fertilizado = false, colhido = false},
    [8] = {2230.03,5574.3,53.9, fertilizado = false, colhido = false},
    [9] = {2217.66,5577.36,53.86, fertilizado = false, colhido = false},
    [10] = {2219.9,5577.23,53.86, fertilizado = false, colhido = false},
    [11] = {2222.17,5577.05, 53.84, fertilizado = false, colhido = false},
    [12] = {2224.47,5576.91,53.85, fertilizado = false, colhido = false},
    [13] = {2226.89,5576.83,53.88, fertilizado = false, colhido = false},
    [14] = {2229.32,5576.65, 53.93, fertilizado = false, colhido = false},
    [15] = {2231.6,5576.33,54.14, fertilizado = false, colhido = false},
    [16] = {2222.93,5579.28,53.93, fertilizado = false, colhido = false},
    [17] = {2224.47,5579.18,53.93, fertilizado = false, colhido = false},
    [18] = {2233.12,5578.64,54.11, fertilizado = false, colhido = false}
}
CreateThread(function()

    while true do 
        local ped = PlayerPedId()

        local dist = GetDistanceBetweenCoords(GetEntityCoords(ped),blipfertilizante[1],blipfertilizante[2],blipfertilizante[3],true)


        if dist <=15 and etapa == 0 then
            DrawMarker(21, blipfertilizante[1],blipfertilizante[2],blipfertilizante[3]-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
            if dist <=1.0 then
                DrawText3Ds(blipfertilizante[1],blipfertilizante[2],blipfertilizante[3],'PRESSIONE ~b~E~w~ PARA PEGAR O FERTILIZANTE')
                if IsControlJustPressed(0, 46) and emp.jpcheckPermissao() then
                    japa = true
                    TriggerEvent('Notify','sucesso','Você pegou os fertilizantes')
                    etapa = 1
                    vRP.playAnim(true,{{"pickup_object","idle"}},true)
                    SetTimeout(1, function()
                        spray = CreateObject(GetHashKey('bkr_prop_weed_spray_01a'), objeto[1],objeto[2],objeto[3]-1, true, true, true)
                        vRP._playAnim(true,{{"anim@heists@box_carry@","idle"}},true)
                        vRP._CarregarObjeto("anim@heists@box_carry@","idle","bkr_prop_weed_bucket_01a",50,28422,0.0,-0.1,-0.18,0.0,0.0,0.0)
                    end)
                end
            end
        end

        if etapa == 1 then
            local dist = GetDistanceBetweenCoords(GetEntityCoords(ped),blipdeixarfertiliaznte[1],blipdeixarfertiliaznte[2],blipdeixarfertiliaznte[3],true)
            if dist <=15 then 
                DrawMarker(21, blipdeixarfertiliaznte[1],blipdeixarfertiliaznte[2],blipdeixarfertiliaznte[3]-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
                if dist <=1.0 then
                    DrawText3Ds(blipdeixarfertiliaznte[1],blipdeixarfertiliaznte[2],blipdeixarfertiliaznte[3],'PRESSIONE ~b~E~w~ PARA COLOCAR O FERTILIZANTE NO CHÃO')
                    if IsControlJustPressed(0, 46) then
                        etapa = 2
                        SetEntityCoords(ped,2210.95,5577.9,53.9-1)
                        SetEntityHeading(ped, 271.8)
                        vRP._DeletarObjeto(source)
                        emp.jpCongelado(1000)
                        vRP._playAnim(false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},false)
                        Wait(1000)
                        TriggerEvent('Notify','sucesso','Você colocou os fertilizantes no chão')
                        fert = CreateObject(GetHashKey('bkr_prop_weed_bucket_01a'), blipdeixarfertiliaznte[1],blipdeixarfertiliaznte[2],blipdeixarfertiliaznte[3]-1, true, true, true)
                        vRP._stopAnim(source,false)
                    end
                end
            end
        end

        if etapa == 2 then
            local dist = GetDistanceBetweenCoords(GetEntityCoords(ped),blipdeixarfertiliaznte[1],blipdeixarfertiliaznte[2],blipdeixarfertiliaznte[3],true)
            if dist <= 3 then
                DrawText3Ds(objeto[1],objeto[2],objeto[3],'PRESSIONE ~b~E~w~ PARA PEGAR O SPRAY')
            end
            if IsControlJustPressed(0, 46) then 
                vRP._playAnim(false,{{"anim@amb@business@weed@weed_inspecting_lo_med_hi@","weed_crouch_checkingleaves_idle_01_inspector"}},false)
                SetEntityCoords(ped,2211.1,5578.87,53.76-1)
                SetEntityHeading(ped, 264.82)
                Wait(1000)
                TriggerEvent('Notify','sucesso','Você pegou o spray de fertilizante')
                DeleteObject(spray)
                vRP._stopAnim(source,false)
                vRP._CarregarObjeto("","","bkr_prop_weed_spray_01a",50,28422,0.0,-0.1,-0.18,0.0,0.0,0.0)
                etapa = 3
            end
        end

        for k,v in pairs(plantacoes) do
            local dist = GetDistanceBetweenCoords(GetEntityCoords(ped),v[1],v[2],v[3],true)
            if dist <= 1.0 and v.fertilizado == false and etapa == 3 then
                DrawText3Ds(v[1],v[2],v[3],'PRESSIONE ~b~E~w~ PARA FERTILIZAR OS PÉS')
                if IsControlJustPressed(0, 46) then
                    vRP._DeletarObjeto(source)
                    SetEntityCoords(ped, v[1],v[2],v[3]-1)
                    SetEntityHeading(ped, 256.58)
                    vRP._playAnim(true,{{"anim@amb@business@weed@weed_inspecting_lo_med_hi@","weed_spraybottle_stand_spraying_02_inspectorfemale"}},true)
					vRP._CarregarObjeto("","","bkr_prop_weed_spray_01a",50,57005,0.15,0.02,-0.1,0.0,0.0,0.0)	 
                    emp.jpCongelado(10000)
                    Wait(10000)
                    vRP._stopAnim(source,false)
                    vRP._DeletarObjeto(source)
                    v.fertilizado = true
                    colhido = false  
                    TriggerEvent('Notify','sucesso','Você fertilizou o pé')
                end
            end
            if v.fertilizado == true and v.colhido == false then
                if dist <= 1 then
                    DrawText3Ds(v[1],v[2],v[3],'PRESSIONE ~b~E~w~ PARA COLHER')
                    if IsControlJustPressed(0, 46) then
                        emp.jpCongelado(10000)
                        SetEntityCoords(ped, v[1],v[2],v[3]-1)
                        SetEntityHeading(ped, 256.58)
                        vRP._playAnim(false,{{"anim@amb@business@weed@weed_inspecting_lo_med_hi@","weed_crouch_checkingleaves_idle_01_inspector"}},false)
                        Wait(10000)
                        vRP._stopAnim(soruce, false)
                        emp.jpcheckPagamento()
                        TriggerEvent('Notify','sucesso', 'Você colheu as maconhas')
                        v.colhido = true
                    end
                end
            end
            if plantacoes[3]['colhido'] and plantacoes[8]['colhido'] and plantacoes[18]['colhido'] == true then
                etapa = 0 
                japa = false
                DeleteObject(fert)
            end 
        end

        if japa then
            DisableControlAction(0,167,true)
            DisableControlAction(0,21,true)
            DisableControlAction(0,22,true)
        end
        
        Wait(1)
    end
end)

function DrawText3Ds(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.34, 0.34)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.001+ factor, 0.028, 0, 0, 0, 78)
end