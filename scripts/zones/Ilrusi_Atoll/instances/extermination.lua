-----------------------------------
-- Assault: Extermination
-----------------------------------
local ID = zones[xi.zone.ILRUSI_ATOLL]
local InstanceAssault = xi.assault.InstanceAssault
-----------------------------------
local content = InstanceAssault:new({
    assaultID        = xi.assault.mission.EXTERMINATION,
    instanceID       = xi.assault.instanceID.EXTERMINATION,
    requiredOrders   = xi.ki.ILRUSI_ASSAULT_ORDERS,
    zoneID           = xi.zone.ILRUSI_ATOLL,
    assaultArea      = xi.assault.assaultArea.ILRUSI_ATOLL,

    entranceParams   = { 5502, { 219, 43, -4, 0, 70, 4, 1 }, { 219, 4 }, { 147, 0 } },
    runeOfReleasePos = { x = 296.000, y = -3.692, z = 132.339, rot = 148 },
    ancientBoxPos    = { x = 294.000, y = -3.606, z = 132.000, rot = 192 },
    releasePos       = { x = 7, z = 8 }, -- (H-8)

    timeLimit        = 30,
    suggestedLevel   = 70,
    requiredProgress = 20,
    basePoints       = 1100,

    experimental     = true,
})

content.mobs =
{
    { baseID = ID.mob[content.assaultID].CARRION_MOBS, offset = 19, }, -- Group 1
}

content.npcs = {}

content.wallNPCs =
{
    ID.npc._1jo,
    ID.npc._jj3,
    ID.npc._jj5,
    ID.npc._jjc,
}

content.loot =
{
    -- appraisal =
    -- {
    --     [xi.item.UNAPPRAISED_BOX] =
    --     {
    --         {
    --             { 25, xi.item.FLASK_OF_DISTILLED_WATER },
    --             { 25, xi.item.LITTLE_WORM              },
    --             { 15, xi.item.RUSTY_BUCKET             },
    --             { 10, xi.item.LAMIAN_ARMLET            },
    --             {  5, xi.item.KING_TRUFFLE             },
    --             {  5, xi.item.QUTRUB_GORGET            },
    --             {  4, xi.item.BEETLE_QUIVER            },
    --             {  4, xi.item.STONE_QUIVER             },
    --             {  3, xi.item.BONE_QUIVER              },
    --             {  2, xi.item.SLEEP_QUIVER             },
    --             {  2, xi.item.SILVER_QUIVER            },
    --         },
    --     },

    --     [xi.item.UNAPPRAISED_FOOTWEAR] =
    --     {
    --         {
    --             { 35, xi.item.ASH_CLOGS          },
    --             { 35, xi.item.LEATHER_HIGHBOOTS  },
    --             {  5, xi.item.STORM_CRACKOWS     },
    --             { 25, xi.item.BRONZE_LEGGINGS_P1 },
    --         },
    --     },
    --     [xi.item.UNAPPRAISED_POLEARM] =
    --     {
    --         {
    --             { 35, xi.item.BRASS_ZAGHNAL     },
    --             { 20, xi.item.SPARK_SPEAR       },
    --             { 20, xi.item.WILLOW_WAND_P1    },
    --             { 15, xi.item.HOLLY_STAFF_P1    },
    --             { 10, xi.item.VOLUNTEERS_SCYTHE },
    --         },
    --     },
    --     [xi.item.UNAPPRAISED_AXE] =
    --     {
    --         { 100, xi.item.PICKAXE },
    --     },
    -- },

    -- items =
    -- {
    --     -- Regular Item drops
    --     { item = xi.item.HI_POTION_P3,       chance = 1000, },
    --     { item = xi.item.HI_RERAISER,        chance = 125,  },
    --     { item = xi.item.HI_POTION_TANK,     chance = 500,  },
    --     { item = xi.item.HI_ETHER_TANK,      chance = 10,   },
    --     { item = xi.item.WILLOW_FISHING_ROD, chance = 10,   },

    --     -- ??? Items
    --     { item = xi.item.UNAPPRAISED_BOX,      chance = 500, },
    --     { item = xi.item.UNAPPRAISED_POLEARM,  chance = 250, },
    --     { item = xi.item.UNAPPRAISED_FOOTWEAR, chance = 250, },
    --     { item = xi.item.UNAPPRAISED_AXE,      chance =  10, },
    -- }
}

return content:register()
