-----------------------------------
-- Area: Windurst Woods
--  NPC: Kyaa Taali
-- Type: Bonecraft Image Support
-- !pos -10.470 -6.25 -141.700 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local guildMember = isGuildMember(player, 2)
    local SkillCap = getCraftSkillCap(player, tpz.skill.BONECRAFT)
    local SkillLevel = player:getSkillLevel(tpz.skill.BONECRAFT)

    if guildMember == 1 then
        if not player:hasStatusEffect(tpz.effect.BONECRAFT_IMAGERY) then
            player:startEvent(10020, SkillCap, SkillLevel, 2, 509, player:getGil(), 0, 0, 0)
        else
            player:startEvent(10020, SkillCap, SkillLevel, 2, 511, player:getGil(), 7147, 0, 0)
        end
    else
        player:startEvent(10020) -- Standard Dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 10020 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 6, 2)
        player:addStatusEffect(tpz.effect.BONECRAFT_IMAGERY, 1, 0, 120)
    end
end
