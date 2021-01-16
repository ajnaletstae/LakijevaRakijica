-- OVDE NE PIPAJ NISTA --
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterUsableItem('rakijica', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('rakijica', 1)
	TriggerClientEvent('lakijeva-rakija:onRakijica', _source)
end)

