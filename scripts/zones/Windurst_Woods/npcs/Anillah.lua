-----------------------------------
-- Area: Windurst Woods
--  NPC: Anillah
-- Type: Clothcraft Image Support
-- !pos -34.800 -2.25 -119.950 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local guildMember = isGuildMember(player, 3)
    local SkillCap = getCraftSkillCap(player, tpz.skill.CLOTHCRAFT)
    local SkillLevel = player:getSkillLevel(tpz.skill.CLOTHCRAFT)

    if guildMember == 1 then
        if not player:hasStatusEffect(tpz.effect.CLOTHCRAFT_IMAGERY) then
            player:startEvent(10015, SkillCap, SkillLevel, 2, 511, player:getGil(), 0, 0, 0) -- p1 = skill level
        else
            player:startEvent(10015, SkillCap, SkillLevel, 2, 511, player:getGil(), 7108, 0, 0)
        end
    else
        player:startEvent(10015) -- Standard Dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 10015 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 4, 2)
        player:addStatusEffect(tpz.effect.CLOTHCRAFT_IMAGERY, 1, 0, 120)
    end
end
