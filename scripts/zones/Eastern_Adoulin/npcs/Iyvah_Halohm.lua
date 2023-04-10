-----------------------------------
-- Area: Eastern Adoulin (257)
--  NPC: Iyvah Halohm
-- Type: Adoulin Fame Checking NPC
-- !pos -61.044 -0.150 -5.239 257
-----------------------------------
require('scripts/globals/quests')
-----------------------------------

local entity = {}

entity.onTrigger = function(player, npc)
    local imprimatursSpent = 0 -- TODO: Confirm this
    local adoulinFame = player:getFameLevel(xi.quest.fame_area.ADOULIN)

    -- TODO: Hook these up
    local pioneersRank = 0
    local peacekeepersRank = 0
    local couriersRank = 0
    local scoutsRank = 0
    local inventorsRank = 0
    local mummersRank = 0

    player:startEvent(562,
        imprimatursSpent, adoulinFame,
        pioneersRank, peacekeepersRank, couriersRank,
        scoutsRank, inventorsRank, mummersRank)
end

return entity
