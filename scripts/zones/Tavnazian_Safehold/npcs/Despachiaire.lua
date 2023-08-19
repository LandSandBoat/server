-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Despachiaire
-- !pos 108 -40 -83 26
-- TODO:
-- Starts quests: "X Marks the Spot"
--                "Elderly Pursuits"
--                "Tango with a Tracker"
--                "Requiem of Sin"
-- Involved in:   "Secrets of Ovens Lost"
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

-- TODO: cutscenes including Despachiaire for reference
--Despachiaire     102 ++
--Despachiaire     104 ++
--Despachiaire     106 ++
--Despachiaire     107 ++
--Despachiaire     108 ++
--Despachiaire     110 ++
--Despachiaire     112 ++
--Despachiaire     117 ++
--Despachiaire     118 ++
--Despachiaire     132
--Despachiaire     133
--Despachiaire     134 ??
--Despachiaire     139
--Despachiaire     144 chat
--Despachiaire     149 XX
--Despachiaire     315 chat
--Despachiaire     317 chat
--Despachiaire     318 chat
--Despachiaire     505 CS
--Despachiaire     517 CS (despachiaire's wife)
--Despachiaire     518 CS (ulmia mother)
--Despachiaire     576 CS
--Despachiaire     577 chat
--Despachiaire     578 chat
--Despachiaire     579 chat
--Despachiaire     617 XX
--Despachiaire     618 XX

return entity
