function onLoad()
    Hands.hiding = 3
    updatehandvisibility()
end

function onPlayerChangeColor(color)
    updatehandvisibility()
end

function updatehandvisibility()
    for i, hand in ipairs(Hands.getHands()) do
        for j, object in ipairs(hand.getObjects()) do
            onObjectEnterZone(hand, object)
        end
    end
end

function getNonSpectators(exceptColor)
    nonSpectators = {}
    for i, color in ipairs(Player.getColors()) do
        if color ~= "Grey"  and color ~= exceptColor then
            table.insert(nonSpectators, color)
        end
    end
    
    return nonSpectators
end

function onObjectEnterZone(zone, enteringObject)
    if zone.type ~= "Hand" then
        return
    end

    enteringObject.setHiddenFrom(getNonSpectators(zone.getData()["FogColor"]))
end

function onObjectLeaveZone(zone, leavingObject)
    if zone.type ~= "Hand" then
        return
    end
    
    leavingObject.setHiddenFrom({})
end

function onDestroy()
    Hands.hiding = 1
end