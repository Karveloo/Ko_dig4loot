local digging = false

-- chekkaa locaatio
function isPlayerInDigArea()
    for _, location in pairs(Config.DiggingLocations) do
        if #(GetEntityCoords(PlayerPedId()) - location) <= Config.DigRadius then
            return true
        end
    end
    return false
end

-- token
RegisterNetEvent('digging:verify')
AddEventHandler('digging:verify', function (token)
    digToken = token
end)

-- digging
RegisterNetEvent("digging:start")
AddEventHandler("digging:start", function()
    if digging then return end

    if not isPlayerInDigArea() then
        lib.notify({ title = Config.locales.digging, description = Config.locales.inarea, type = "information" })
        return
    end
        local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 1},}, {'w', 'a', 's', 'd'})
        if success then
            digging = true
            if lib.progressCircle({
                duration = 5000,
                label = Config.locales.digging,
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                    movement = true
                },
                anim = {
                    dict = "random@burial",
                    clip = "a_burial",
                },
                prop = {
                    model = GetHashKey("prop_tool_shovel"),
                    bone = 28422,
                    pos = vector3(0.03, 0.01, 0.2),
                    rot = vector3(0.0, 0.0, -9.5)
                },
            }) then
                if digToken then
                    TriggerServerEvent("digging:reward", digToken)
                    digToken = nil
                    lib.notify({ title = Config.locales.digging, description = Config.locales.find, type = "success" })
                else print('[SECURITY] no valid token')
                end
                else
                    lib.notify({ title = Config.locales.digging, description = Config.locales.canceled, type = "information" })
                end
                digging = false
        else
            lib.notify({ title = Config.locales.digging, description = Config.locales.failed, type = "error" })
    end
end)

CreateThread(function()
    for _, loc in pairs(Config.DiggingLocations) do
	blip = AddBlipForCoord(loc)
    SetBlipSprite(blip, 273)
	SetBlipColour(blip, 0)
	SetBlipScale(blip, 0.8)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
	AddTextComponentString('Kaivuualue')
    EndTextCommandSetBlipName(blip)
    area_blip = AddBlipForRadius(loc, Config.DigRadius)
    SetBlipSprite(area_blip, 10)
    end
end)
