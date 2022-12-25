-----------------------------------
-- Area: Bearclaw Pinnacle
--  NPC: Armoury Crate
-----------------------------------
require("scripts/globals/battlefield")
-----------------------------------
local entity = {}

-- Leaving this loot here until their respective battlefields are implemented
 local loot =
 {
     -- ENM: Follow the White Rabbit
     [641] =
     {
         {
             { itemid =    0, droprate =  50 }, -- nothing
             { itemid = 1769, droprate = 450 }, -- Square of Galateia
             { itemid = 1764, droprate =  50 }, -- Kejusu Satin
             { itemid = 1763, droprate = 450 }, -- Viridian Urushi
         },

         {
             { itemid =    0, droprate = 950 }, -- nothing
             { itemid = 1842, droprate =  50 }, -- Cloud Evoker
         },

         {
             { itemid =     0, droprate = 325 }, -- nothing
             { itemid = 18380, droprate = 225 }, -- Martial Sword
             { itemid = 17798, droprate = 125 }, -- Shamo
             { itemid = 15301, droprate =  50 }, -- Venturer's Belt
             { itemid = 14673, droprate = 100 }, -- Serene Ring
             { itemid =  4748, droprate = 175 }, -- Scroll of Raise III
         },

         {
             { itemid =     0, droprate = 325 }, -- nothing
             { itemid = 18380, droprate = 225 }, -- Martial Sword
             { itemid = 17798, droprate = 125 }, -- Shamo
             { itemid = 15301, droprate =  50 }, -- Venturer's Belt
             { itemid = 14673, droprate = 100 }, -- Serene Ring
             { itemid =  4748, droprate = 175 }, -- Scroll of Raise III
         },
     },

     -- ENM: When Hell Freezes Over
     [642] =
     {
         {
             { itemid =    0, droprate = 100 }, -- nothing
             { itemid = 1769, droprate = 500 }, -- Square of Galateia
             { itemid = 1764, droprate = 150 }, -- Kejusu Satin
             { itemid = 1763, droprate = 250 }, -- Viridian Urushi
         },

         {
             { itemid =    0, droprate = 950 }, -- nothing
             { itemid = 1842, droprate =  50 }, -- Cloud Evoker
         },

         {
             { itemid =     0, droprate = 250 }, -- nothing
             { itemid = 18221, droprate = 125 }, -- Martial Bhuj
             { itemid = 17210, droprate = 125 }, -- Martial Gun
             { itemid = 17593, droprate = 125 }, -- Martial Staff
             { itemid = 13628, droprate = 125 }, -- Hexerei Cape
             { itemid = 13647, droprate = 125 }, -- Settler's Cape
             { itemid =  4748, droprate = 125 }, -- Scroll of Raise III
         },

         {
             { itemid =     0, droprate = 250 }, -- nothing
             { itemid = 18221, droprate = 125 }, -- Martial Bhuj
             { itemid = 17210, droprate = 125 }, -- Martial Gun
             { itemid = 17593, droprate = 125 }, -- Martial Staff
             { itemid = 13628, droprate = 125 }, -- Hexerei Cape
             { itemid = 13647, droprate = 125 }, -- Settler's Cape
             { itemid =  4748, droprate = 125 }, -- Scroll of Raise III
         },
     },

     -- ENM: Brothers

     [643] =
     {
         {
             { itemid = xi.items.NONE, droprate = 100 },
             { itemid = xi.items.SQUARE_OF_ELTORO_LEATHER, droprate = 500 },
             { itemid = xi.items.PIECE_OF_CASSIA_LUMBER, droprate = 150 },
             { itemid = xi.items.DRAGON_BONE, droprate = 250 },
         },

         {
             { itemid = xi.items.NONE, droprate = 950 },
             { itemid = xi.items.CLOUD_EVOKER, droprate =  50 },
         },

         {
             { itemid = xi.items.NONE, droprate = 250 },
             { itemid = xi.items.SCOUTERS_ROPE, droprate = 125 },
             { itemid = xi.items.HEDGEHOG_BOMB, droprate = 125 },
             { itemid = xi.items.MARTIAL_ANELACE, droprate = 125 },
             { itemid = xi.items.MARTIAL_LANCE, droprate = 125 },
             { itemid = xi.items.SCROLL_OF_RAISE_III, droprate = 125 },
         },

         {
            { itemid = xi.items.NONE, droprate = 250 },
            { itemid = xi.items.SCOUTERS_ROPE, droprate = 125 },
            { itemid = xi.items.HEDGEHOG_BOMB, droprate = 125 },
            { itemid = xi.items.MARTIAL_ANELACE, droprate = 125 },
            { itemid = xi.items.MARTIAL_LANCE, droprate = 125 },
            { itemid = xi.items.SCROLL_OF_RAISE_III, droprate = 125 },
        },
     },

     -- ENM: Holy Cow
     [644] =
     {
         {
             { itemid = xi.items.NONE, droprate = 100 }, -- nothing
             { itemid = xi.items.SQUARE_OF_ELTORO_LEATHER, droprate = 500 }, -- Square of Galateia
             { itemid = xi.items.PIECE_OF_CASSIA_LUMBER, droprate = 150 }, -- Kejusu Satin
             { itemid = xi.items.DRAGON_BONE, droprate = 250 }, -- Viridian Urushi
         },

         {
             { itemid = xi.items.NONE, droprate = 950 }, -- nothing
             { itemid = xi.items.CLOUD_EVOKER, droprate =  50 }, -- Cloud Evoker
         },

         {
             { itemid = xi.items.NONE, droprate = 250 }, -- nothing
             { itemid = xi.items.GIGANT_MANTLE, droprate = 125 }, -- Martial Bhuj
             { itemid = xi.items.PSILOS_MANTLE, droprate = 125 }, -- Martial Gun
             { itemid = xi.items.MARTIAL_BOW, droprate = 125 }, -- Martial Staff
             { itemid = xi.items.MARTIAL_KNUCKLES, droprate = 125 }, -- Hexerei Cape
             { itemid = xi.items.SCROLL_OF_RAISE_III, droprate = 125 }, -- Settler's Cape
         },

         {
            { itemid = xi.items.NONE, droprate = 250 }, -- nothing
            { itemid = xi.items.GIGANT_MANTLE, droprate = 125 }, -- Martial Bhuj
            { itemid = xi.items.PSILOS_MANTLE, droprate = 125 }, -- Martial Gun
            { itemid = xi.items.MARTIAL_BOW, droprate = 125 }, -- Martial Staff
            { itemid = xi.items.MARTIAL_KNUCKLES, droprate = 125 }, -- Hexerei Cape
            { itemid = xi.items.SCROLL_OF_RAISE_III, droprate = 125 }, -- Settler's Cape
        },
     },
 }

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local battlefield = player:getBattlefield()
    if battlefield then
        xi.battlefield.HandleLootRolls(battlefield, loot[battlefield:getID()], nil, npc)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
