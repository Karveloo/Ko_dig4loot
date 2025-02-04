local digging = false

-- chekka locaatio
function isPlayerInDigArea()
    for _, location in pairs(Config.DiggingLocations) do
        if #(GetEntityCoords(PlayerPedId()) - location) <= Config.DigRadius then
            return true
        end
    end
    return false
end

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
            if lib.progressCircle({
                duration = 5000,
                label = Config.locales.digging,
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                    movement = true
                },
                anim = { dict = "amb@world_human_gardener_plant@male@idle_a", 
                clip = "idle_a" 
            },
                prop = {
                    model = `prop_tool_shovel`,
                    bone = 28422,
                    pos = { x = 0.15, y = 0.0, z = 0.0 },
                    rot = { x = 0.0, y = 0.0, z = 60.0 },
                },
            }) then
                    TriggerServerEvent("digging:reward")
                    lib.notify({ title = Config.locales.digging, description = Config.locales.find, type = "success" })
                else
                    lib.notify({ title = Config.locales.digging, description = Config.locales.canceled, type = "information" })
                end
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