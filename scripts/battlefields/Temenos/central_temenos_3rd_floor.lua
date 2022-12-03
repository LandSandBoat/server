-----------------------------------
-- Area: Temenos
-- Name: Central Temenos 3rrd Floor
-- !addkeyitem white_card
-- !addkeyitem cosmo_cleanse
-- !additem ivory_chip
-- !pos 580.000 -2.375 104.000 37
-----------------------------------
local ID = require("scripts/zones/Temenos/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/limbus")
require("scripts/globals/items")
require("scripts/globals/keyitems")
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.TEMENOS,
    battlefieldId    = xi.battlefield.id.CENTRAL_TEMENOS_3RD_FLOOR,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(45),
    index            = 4,
    area             = 5,
    entryNpc         = 'Matter_Diffusion_Module',
    requiredKeyItems = { xi.ki.COSMO_CLEANSE, xi.ki.WHITE_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    requiredItems    = { xi.items.IVORY_CHIP },
    name             = "CENTRAL_TEMENOS_3RD_FLOOR",
})

function content:handleWeakenBoss(name, battlefield, mob)
    local boss = mob:getZone():queryEntitiesByName(name)[1]
    boss:setMod(xi.mod.REGAIN, 0)
end

function content:handleStrengthenBosses(bonusMod, amount, battlefield, mob, count)
    local bosses = { "Abyssdweller_Jhabdebb", "Orichalcum_Quadav", "Pee_Qoho_the_Python" }
    for _, name in ipairs(bosses) do
        local boss = mob:getZone():queryEntitiesByName(name)[1]
        if boss:isAlive() then
            boss:injectActionPacket(boss:getID(), 11, 439, 0, 24, 0, 307, 0)
            boss:addMod(bonusMod, amount)
        end
    end
end

content.groups =
{
    {
        mobs =
        {
            "Abyssdweller_Jhabdebb",
            "Orichalcum_Quadav",
            "Pee_Qoho_the_Python",
            "Grognard_Mesmerizer",
            "Grognard_Footsoldier",
            "Grognard_Predator",
            "Grognard_Neckchopper",
            "Grognard_Grappler",
            "Grognard_Impaler",
            "Star_Ruby_Quadav",
            "Fossil_Quadav",
            "Whitegold_Quadav",
            "Wootz_Quadav",
            "Star_Sapphire_Quadav",
            "Lightsteel_Quadav",
            "Yagudo_Archpriest",
            "Yagudo_Disciplinant",
            "Yagudo_Kapellmeister",
            "Yagudo_Knight_Templar",
            "Yagudo_Prelatess",
            "Yagudo_Eradicator",
        },

        mixins = { require("scripts/mixins/job_special") }
    },

    {
        mobs = { "Yagudos_Avatar" },
        mixins = { require("scripts/mixins/families/avatar") },
        spawned = false,
    },

    {
        mobs =
        {
            "Yagudos_Elemental",
            "Yagudos_Avatar",
            "Orcs_Wyvern",
        },
        spawned = false,
    },

    {
        mobs =
        {
            "Grognard_Mesmerizer",
            "Grognard_Footsoldier",
            "Grognard_Predator",
            "Grognard_Neckchopper",
            "Grognard_Grappler",
            "Grognard_Impaler",
        },

        allDeath = utils.bind(content.handleWeakenBoss, content, "Abyssdweller_Jhabdebb"),
    },

    {
        mobs =
        {
            "Star_Ruby_Quadav",
            "Fossil_Quadav",
            "Whitegold_Quadav",
            "Wootz_Quadav",
            "Star_Sapphire_Quadav",
            "Lightsteel_Quadav",
        },

        allDeath = utils.bind(content.handleWeakenBoss, content, "Orichalcum_Quadav"),
    },

    {
        mobs =
        {
            "Yagudo_Archpriest",
            "Yagudo_Disciplinant",
            "Yagudo_Kapellmeister",
            "Yagudo_Knight_Templar",
            "Yagudo_Prelatess",
            "Yagudo_Eradicator",
        },

        allDeath = utils.bind(content.handleWeakenBoss, content, "Pee_Qoho_the_Python"),
    },

    {
        mobs = { "Abyssdweller_Jhabdebb" },
        death = utils.bind(content.handleStrengthenBosses, content, xi.mod.ATTP, 50),
    },

    {
        mobs = { "Orichalcum_Quadav" },
        death = utils.bind(content.handleStrengthenBosses, content, xi.mod.UDMGPHYS, 5000),
    },

    {
        mobs = { "Pee_Qoho_the_Python" },
        death = utils.bind(content.handleStrengthenBosses, content, xi.mod.UDMGMAGIC, 5000),
    },

    {
        mobs =
        {
            "Abyssdweller_Jhabdebb",
            "Orichalcum_Quadav",
            "Pee_Qoho_the_Python",
        },

        mods =
        {
            [xi.mod.REGAIN] = 150,
            [xi.mobMod.DETECTION] = xi.detects.HEARING,
        },

        isParty = true,
        allDeath = function(battlefield, mob)
            npcUtil.showCrate(GetEntityByID(ID.CENTRAL_TEMENOS_3RD_FLOOR.npc.LOOT_CRATE))
        end
    },

}

content.loot =
{
    [ID.CENTRAL_TEMENOS_3RD_FLOOR.npc.LOOT_CRATE] =
    {
        {
            quantity = 7,
            { itemid = 1875, droprate = 1000 },
        },

        {
            { itemid = 1934, droprate =  53 },
            { itemid = 1940, droprate = 132 },
            { itemid = 1954, droprate = 105 },
            { itemid = 1932, droprate = 211 },
            { itemid = 1956, droprate = 211 },
            { itemid = 1930, droprate = 100 },
            { itemid = 2658, droprate = 211 },
            { itemid = 2716, droprate = 105 },
        },

        {
            { itemid = 1907, droprate = 1000 },
        },
    }
}

return content:register()
