-----------------------------------
-- Information on Mannequins
-----------------------------------

xi = xi or {}
xi.mannequin = xi.mannequin or {}

xi.mannequin.cost =
{
    PURCHASE  = 100000,
    TRADE     = 2000,
    POSE      = 200,
}

xi.mannequin.getMannequins = function(player)
    local mannequinMask = 0
    for itemId = xi.item.HUME_M_MANNEQUIN, xi.item.GALKA_MANNEQUIN do
        if player:hasItem(itemId) then
            mannequinMask = utils.mask.setBit(mannequinMask, itemId - xi.item.HUME_M_MANNEQUIN, true)
        end
    end

    return mannequinMask
end

xi.mannequin.setMannequinPose = function(player, race, pose)
    -- Race = 1 to 8
    player:setMannequinPose(xi.item.HUME_M_MANNEQUIN + race - 1, race, pose)
end

xi.mannequin.getMannequinPose = function(player, race)
    return player:getMannequinPose(xi.item.HUME_M_MANNEQUIN + race - 1)
end
