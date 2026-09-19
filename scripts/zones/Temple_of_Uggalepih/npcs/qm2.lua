-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: ??? (Uggalepih Offering ITEM)
-- !pos 386.253 -0.300 269.696 159
-- !pos 386.144 -0.300 250.465 159
-- !pos 308.617 -1.076 233.508 159
-- !pos 374.148 -0.300 272.672 159
-- !pos 374.045 -0.300 247.471 159
-- !pos 291.577 -1.076 231.248 159
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
---@type TNpcEntity
local entity = {}

local qmPositions =
{
    { 386.253, -0.300, 269.696 },
    { 386.144, -0.300, 250.465 },
    { 308.617, -1.076, 233.508 },
    { 374.148, -0.300, 272.672 },
    { 374.045, -0.300, 247.471 },
    { 291.577, -1.076, 231.248 },
}

entity.onTrigger = function(player, npc)
    if not player:hasItem(xi.item.OFFERING_TO_UGGALEPIH) then
        if npcUtil.giveItem(player, xi.item.OFFERING_TO_UGGALEPIH) then -- Uggalepih Offering
            npc:setStatus(xi.status.DISAPPEAR)
            npc:updateNPCHideTime(7200) -- 2 hours
            npcUtil.queueMove(npc, qmPositions[math.randomInt(1, #qmPositions)])
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
