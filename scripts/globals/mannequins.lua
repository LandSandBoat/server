----------------------------
-- Information on Mannequins
----------------------------

require("scripts/globals/items")

xi = xi or {}
xi.mannequin = xi.mannequin or {}

xi.mannequin.type =
{
    HUME_M   = 0x01,
    HUME_F   = 0x02,
    ELVAAN_M = 0x04,
    ELVAAN_F = 0x08,
    TARU_M   = 0x10,
    TARU_F   = 0x20,
    MITHRA   = 0x40,
    GALKA    = 0x80,
}

xi.mannequin.pose =
{
    NORMAL    = 0x00,
    SIT       = 0x01,
    SALUTE_S  = 0x02,
    SALUTE_B  = 0x03,
    SALUTE_W  = 0x04,
    HURRAY    = 0x08,
    SPECIAL   = 0x10,
}

xi.mannequin.cost =
{
    PURCHASE  = 100000,
    TRADE     = 2000,
    POSE      = 200,
}

xi.mannequin.getMannequins = function(player)
    local mannequinMask = 0
    for itemId = xi.items.HUME_M_MANNEQUIN, xi.items.GALKA_MANNEQUIN do
        if player:hasItem(itemId) then
            mannequinMask = utils.mask.setBit(mannequinMask, itemId - xi.items.HUME_M_MANNEQUIN, true)
        end
    end

    return mannequinMask
end

xi.mannequin.setMannequinPose = function(player, race, pose)
    -- Race = 1 to 8
    player:setMannequinPose(xi.items.HUME_M_MANNEQUIN + race - 1, race, pose)
end

xi.mannequin.getMannequinPose = function(player, race)
    return player:getMannequinPose(xi.items.HUME_M_MANNEQUIN + race - 1)
end
