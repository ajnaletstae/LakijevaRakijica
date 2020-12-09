-- OVDE NE PIPAJ NISTA --
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterUsableItem('rakijica', function(baza)
    local podbaza = baza
	local xPlayer = ESX.GetPlayerFromId(podbaza)
	xPlayer.removeInventoryItem('rakijica', 1)
	TriggerClientEvent('lakijeva-rakija:onRakijica', baza)
end)

