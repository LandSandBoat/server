-----------------------------------
-- Area: Batallia Downs (S)
--  NPC: Shanene
-- !pos 161.183 0.468 91.111 84
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local hasScrollsBundle = player:hasKeyItem(xi.ki.BUNDLE_OF_HALF_INSCRIBED_SCROLLS)
    local hasRainemard = player:hasItem(xi.item.CIPHER_OF_RAINEMARDS_ALTER_EGO) or player:hasSpell(xi.magic.spell.RAINEMARD)

    if hasScrollsBundle and not hasRainemard then
        player:startEvent(36)
    else
        player:startEvent(37)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 36 and option == 2 then
        npcUtil.giveItem(player, xi.item.CIPHER_OF_RAINEMARDS_ALTER_EGO)
    end
end

return entity
