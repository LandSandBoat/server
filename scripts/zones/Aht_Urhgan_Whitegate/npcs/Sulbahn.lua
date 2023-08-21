-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Sulbahn
-- Type: Alchemy Adv. Image Support
-- !pos -10.470 -6.25 -141.700 241
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.ALCHEMY) then
        if npcUtil.tradeHas(trade, xi.item.IMPERIAL_BRONZE_PIECE) then
            if not player:hasStatusEffect(xi.effect.ALCHEMY_IMAGERY) then
                player:confirmTrade()
                player:startEvent(637, 17160, 1, 19405, 21215, 30030, 0, 7, 0)
            else
                npc:showText(npc, ID.text.IMAGE_SUPPORT_ACTIVE)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local skillLevel = player:getSkillLevel(xi.skill.ALCHEMY)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.ALCHEMY) then
        player:startEvent(636, 2, skillLevel, 0, 511, 0, 0, 7, xi.item.IMPERIAL_BRONZE_PIECE)
    else
        player:startEvent(636, 0, 0, 0, 0, 0, 0, 7, 0) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 637 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 7, 0)
        player:addStatusEffect(xi.effect.ALCHEMY_IMAGERY, 3, 0, 480)
    end
end

return entity
