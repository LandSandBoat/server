-----------------------------------------
-- ID: 5267
-- Item: Chunk Of Shu'Meyo Salt
-- Effect: Adds 20 seconds to the Snoll Tzar fight
-----------------------------------------
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/player")
local ID = require("scripts/zones/Bearclaw_Pinnacle/IDs")
-----------------------------------------
local item_object = {}

item_object.onItemCheck= function(target, player)
    local result = 0
	local id = target:getID()
    local checkID = true
    local snollID =
    {
        16801793,
        16801794,
        16801795,
    }

    for _, mobID in pairs(snollID) do
        if mobID == id then
             checkID = false
        end
    end

	if checkID then -- snoll tzar
        result = xi.msg.basic.ITEM_UNABLE_TO_USE
    elseif target:checkDistance(player) > 10 then
        result = xi.msg.basic.TOO_FAR_AWAY
    end

    return result
end

item_object.onItemUse = function(target, player)
    local salt = target:getLocalVar("salty")

    player:messageText(player, ID.text.BEGINS_TO_MELT)

    if salt == 0 then -- random time until shaken off
        target:setLocalVar("delayed", os.time() + 20)
        target:setLocalVar("cooldown", os.time() + math.random(15, 20))
        target:setLocalVar("salty", 1)
        target:setLocalVar("melt", 1)
    end
end

return item_object
