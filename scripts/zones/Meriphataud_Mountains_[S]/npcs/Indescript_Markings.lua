-----------------------------------
-- Area: Meriphataud_Mountains_[S]
--  NPC: Indescript Markings
-- Type: Quest
-- !pos -389 -9 92 97
-----------------------------------
local ID = zones[xi.zone.MERIPHATAUD_MOUNTAINS_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local loafersQuestProgress = player:getCharVar('AF_SCH_BOOTS')

    player:delStatusEffect(xi.effect.SNEAK)

    -- SCH AF Quest - Boots
    if
        loafersQuestProgress > 0 and
        loafersQuestProgress < 3 and
        not player:hasKeyItem(xi.ki.DROGAROGAN_BONEMEAL)
    then
        npcUtil.giveKeyItem(player, xi.ki.DROGAROGAN_BONEMEAL)
        player:setCharVar('AF_SCH_BOOTS', loafersQuestProgress + 1)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
