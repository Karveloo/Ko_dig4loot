ESX = exports["es_extended"]:getSharedObject()


ESX.RegisterUsableItem(Config.RequiredItem, function(source)
    TriggerClientEvent("digging:start", source)
end)

RegisterNetEvent("digging:reward")
AddEventHandler("digging:reward", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if not xPlayer then return end

    local playerCoords = GetEntityCoords(GetPlayerPed(_source))
    local inDigArea = false
    for _, loc in pairs(Config.DiggingLocations) do
        if #(playerCoords - loc) <= Config.DigRadius then
            inDigArea = true
            break
        end
    end

    if not inDigArea then
        print("[Ko dig for loot] player: " .. xPlayer.getName() .. " tried to exploit!")
        return
    end

    local rewardTier = getRewardTier()
    local reward = Config.Rewards[rewardTier][math.random(#Config.Rewards[rewardTier])]

    xPlayer.addInventoryItem(reward, 1)
    print(reward)
    sendToDiscord(xPlayer.getName(), reward)
end)


-- valitte taso
function getRewardTier()
    local chance = math.random(100)
    local cumulative = 0
    for tier, percentage in pairs(Config.RarityChances) do
        cumulative = cumulative + percentage
        if chance <= cumulative then
            return tier
        end
    end
    return "common"
end

function sendToDiscord(player, item)
    PerformHttpRequest("WEBHOOK HERE", function() end, "POST", json.encode({content = string.format("**%s** got **%s** from digging", player, item)}), { ["Content-Type"] = "application/json" })
end