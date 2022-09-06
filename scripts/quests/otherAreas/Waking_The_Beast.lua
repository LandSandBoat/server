-- -----------------------------------
-- -- Waking the Beast
-- -----------------------------------
-- -- Log ID: 4, Quest ID: 32
-- -- ???: !pos -175 8 247
-- -----------------------------------
-- require('scripts/globals/items')
-- require('scripts/globals/keyitems')
-- require('scripts/globals/npc_util')
-- require('scripts/globals/quests')
-- require('scripts/globals/titles')
-- require('scripts/globals/zone')
-- require('scripts/globals/interaction/quest')
-- -----------------------------------
-- local ID = require("scripts/zones/La_Theine_Plateau/IDs")

-- local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.WAKING_THE_BEAST)

-- local updateWakingTheBeast = function(player, clearVars)
--     player:setCharVar("WakingTheBeastReset", getConquestTally())

--     if clearVars then
--         player:setCharVar("WakingTheBeastStatus", 0)
--         player:setCharVar("WakingTheBeastReward", 0)
--     end
-- end

-- quest.reward =
-- {
--     item  = xi.items.CARBUNCLES_POLE,
--     title = xi.title.DISTURBER_OF_SLUMBER,
-- }

-- quest.sections =
-- {
--     {
--         check = function(player, status, vars)
--             return status == QUEST_ACCEPTED
--         end,

--         [xi.zone.LA_THEINE_PLATEAU] =
--         {
--             ['qm3'] =
--             {
--                 onTrigger = function(player, npc)
--                     if
--                         player:hasSpell(xi.magic.spell.IFRIT) and
--                         player:hasSpell(xi.magic.spell.GARUDA) and
--                         player:hasSpell(xi.magic.spell.SHIVA) and
--                         player:hasSpell(xi.magic.spell.RAMUH) and
--                         player:hasSpell(xi.magic.spell.LEAVIATHAN) and
--                         player:hasSpell(xi.magic.spell.TITAN)
--                     then
--                         player:startEvent(207)
--                     end

--                     if player:hasKeyItem(xi.ki.FADED_RUBY) then
--                         player:startEvent(208)
--                     end
--                 end,
--             },

--             onEventFinish =
--             {
--                 [207] = function(player, csid, option, npc)
--                     player:addQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.WAKING_THE_BEAST)
--                     player:addKeyItem(xi.ki.RAINBOW_RESONATOR)
--                     player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.RAINBOW_RESONATOR)
--                 end,

--                 [208] = function(player, csid, option, npc)
--                     player:completeQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.WAKING_THE_BEAST)
--                     player:delKeyItem(xi.ki.FADED_RUBY)
--                 end,
--             },
--         }
--     },

--     {
--         check = function(player, status, vars)
--             return status == QUEST_AVAILABLE and
--             player:hasCompletedMission(xi.mission.log_id.OTHER_AREAS, xi.quest.id.otherAreas.WAKING_THE_BEAST)
--         end,
--     },
-- }

-- return quest
