-- !! NE DIRAJ NISTA AKO NE ZNAS !! --
ESX = nil
local PlayerData = {}
local animPocni = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(1)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('lakijeva-rakija:onRakijica')
AddEventHandler('lakijeva-rakija:onRakijica', function(prop_name)
    local playerPed = PlayerPedId()
    prop_name = prop_name or 'prop_vodka_bottle'
	animPocni = true

    RequestAnimSet("move_m@hobo@a") 
    while not HasAnimSetLoaded("move_m@hobo@a") do
      Citizen.Wait(100)
    end    

    -- OSIM OVOG -- ↓
    --Ako koristite mythic notify skinite onda komentar sa ovog dela ↓
    --exports['mythic_notify']:DoHudText('success', 'Ti si popio rakijicu!')

	Citizen.CreateThread(function()
		local playerPed = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(playerPed, 18905)
        AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
		ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)
			Citizen.Wait(3000)
			animPocni = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
		end)
    end)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator3")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@hobo@a", true)
    SetPedIsDrunk(playerPed, true)
    AnimpostfxPlay("HeistCelebPass", 10000001, true)
    ShakeGameplayCam("DRUNK_SHAKE", 8.0)
    SetEntityHealth(PlayerPedId(), 200)
    SetPedArmour(PlayerPedId(), 200)
    Citizen.Wait(300000)
    SetPedMoveRateOverride(PlayerId(),1.0)
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
    SetPedIsDrunk(PlayerPedId(), false)		
    SetPedMotionBlur(playerPed, false)
    ResetPedMovementClipset(PlayerPedId())
    AnimpostfxStopAll()
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
    SetTimecycleModifierStrength(0.0)
end)
