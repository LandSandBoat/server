-----------------------------------
-- Area: Bearclaw Pinnacle
--  NPC: Armoury Crate
-----------------------------------
local entity = {}

-- Leaving this loot here until their respective battlefields are implemented
-- local loot =
-- {
--     -- ENM: Follow the White Rabbit
--     [641] =
--     {
--         {
--             { itemid =    0, droprate =  50 }, -- nothing
--             { itemid = 1769, droprate = 450 }, -- Square of Galateia
--             { itemid = 1764, droprate =  50 }, -- Kejusu Satin
--             { itemid = 1763, droprate = 450 }, -- Viridian Urushi
--         },

--         {
--             { itemid =    0, droprate = 950 }, -- nothing
--             { itemid = 1842, droprate =  50 }, -- Cloud Evoker
--         },

--         {
--             { itemid =     0, droprate = 325 }, -- nothing
--             { itemid = 18380, droprate = 225 }, -- Martial Sword
--             { itemid = 17798, droprate = 125 }, -- Shamo
--             { itemid = 15301, droprate =  50 }, -- Venturer's Belt
--             { itemid = 14673, droprate = 100 }, -- Serene Ring
--             { itemid =  4748, droprate = 175 }, -- Scroll of Raise III
--         },

--         {
--             { itemid =     0, droprate = 325 }, -- nothing
--             { itemid = 18380, droprate = 225 }, -- Martial Sword
--             { itemid = 17798, droprate = 125 }, -- Shamo
--             { itemid = 15301, droprate =  50 }, -- Venturer's Belt
--             { itemid = 14673, droprate = 100 }, -- Serene Ring
--             { itemid =  4748, droprate = 175 }, -- Scroll of Raise III
--         },
--     },

--     -- ENM: When Hell Freezes Over
--     [642] =
--     {
--         {
--             { itemid =    0, droprate = 100 }, -- nothing
--             { itemid = 1769, droprate = 500 }, -- Square of Galateia
--             { itemid = 1764, droprate = 150 }, -- Kejusu Satin
--             { itemid = 1763, droprate = 250 }, -- Viridian Urushi
--         },

--         {
--             { itemid =    0, droprate = 950 }, -- nothing
--             { itemid = 1842, droprate =  50 }, -- Cloud Evoker
--         },

--         {
--             { itemid =     0, droprate = 250 }, -- nothing
--             { itemid = 18221, droprate = 125 }, -- Martial Bhuj
--             { itemid = 17210, droprate = 125 }, -- Martial Gun
--             { itemid = 17593, droprate = 125 }, -- Martial Staff
--             { itemid = 13628, droprate = 125 }, -- Hexerei Cape
--             { itemid = 13647, droprate = 125 }, -- Settler's Cape
--             { itemid =  4748, droprate = 125 }, -- Scroll of Raise III
--         },

--         {
--             { itemid =     0, droprate = 250 }, -- nothing
--             { itemid = 18221, droprate = 125 }, -- Martial Bhuj
--             { itemid = 17210, droprate = 125 }, -- Martial Gun
--             { itemid = 17593, droprate = 125 }, -- Martial Staff
--             { itemid = 13628, droprate = 125 }, -- Hexerei Cape
--             { itemid = 13647, droprate = 125 }, -- Settler's Cape
--             { itemid =  4748, droprate = 125 }, -- Scroll of Raise III
--         },
--     },
-- }

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
