-----------------------------------
-- Area: Temenos
-- Name: Central Temenos 3rrd Floor
-- !addkeyitem white_card
-- !addkeyitem cosmo_cleanse
-- !additem ivory_chip
-- !pos 580.000 -2.375 104.000 37
-----------------------------------
local ID = zones[xi.zone.TEMENOS]
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
    requiredItems    = { xi.item.IVORY_CHIP },
    name             = 'CENTRAL_TEMENOS_3RD_FLOOR',
    lootCrateId      = ID.npc.C3_LOOT_CRATE,
})

function content:handleWeakenBoss(name, battlefield, mob)
    local boss = mob:getZone():queryEntitiesByName(name)[1]
    boss:setMod(xi.mod.REGAIN, 0)
end

function content:handleStrengthenBosses(bonusMod, amount, battlefield, mob, count)
    local bosses = { 'Abyssdweller_Jhabdebb', 'Orichalcum_Quadav', 'Pee_Qoho_the_Python' }

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
            'Abyssdweller_Jhabdebb',
            'Orichalcum_Quadav',
            'Pee_Qoho_the_Python',
            'Grognard_Mesmerizer',
            'Grognard_Footsoldier',
            'Grognard_Predator',
            'Grognard_Neckchopper',
            'Grognard_Grappler',
            'Grognard_Impaler',
            'Star_Ruby_Quadav',
            'Fossil_Quadav',
            'Whitegold_Quadav',
            'Wootz_Quadav',
            'Star_Sapphire_Quadav',
            'Lightsteel_Quadav',
            'Yagudo_Archpriest',
            'Yagudo_Disciplinant',
            'Yagudo_Kapellmeister',
            'Yagudo_Knight_Templar',
            'Yagudo_Prelatess',
            'Yagudo_Eradicator',
        },

        mixins = { require('scripts/mixins/job_special') }
    },

    {
        mobs    = { 'Yagudos_Avatar' },
        mixins  = { require('scripts/mixins/families/avatar') },
        spawned = false,
    },

    {
        mobs =
        {
            'Yagudos_Elemental',
            'Yagudos_Avatar',
            'Orcs_Wyvern',
        },
        spawned = false,
    },

    {
        mobs =
        {
            'Grognard_Mesmerizer',
            'Grognard_Footsoldier',
            'Grognard_Predator',
            'Grognard_Neckchopper',
            'Grognard_Grappler',
            'Grognard_Impaler',
        },

        allDeath = utils.bind(content.handleWeakenBoss, content, 'Abyssdweller_Jhabdebb'),
    },

    {
        mobs =
        {
            'Star_Ruby_Quadav',
            'Fossil_Quadav',
            'Whitegold_Quadav',
            'Wootz_Quadav',
            'Star_Sapphire_Quadav',
            'Lightsteel_Quadav',
        },

        allDeath = utils.bind(content.handleWeakenBoss, content, 'Orichalcum_Quadav'),
    },

    {
        mobs =
        {
            'Yagudo_Archpriest',
            'Yagudo_Disciplinant',
            'Yagudo_Kapellmeister',
            'Yagudo_Knight_Templar',
            'Yagudo_Prelatess',
            'Yagudo_Eradicator',
        },

        allDeath = utils.bind(content.handleWeakenBoss, content, 'Pee_Qoho_the_Python'),
    },

    {
        mobs  = { 'Abyssdweller_Jhabdebb' },
        death = utils.bind(content.handleStrengthenBosses, content, xi.mod.ATTP, 50),
    },

    {
        mobs  = { 'Orichalcum_Quadav' },
        death = utils.bind(content.handleStrengthenBosses, content, xi.mod.UDMGPHYS, 5000),
    },

    {
        mobs  = { 'Pee_Qoho_the_Python' },
        death = utils.bind(content.handleStrengthenBosses, content, xi.mod.UDMGMAGIC, 5000),
    },

    {
        mobs =
        {
            'Abyssdweller_Jhabdebb',
            'Orichalcum_Quadav',
            'Pee_Qoho_the_Python',
        },

        mods =
        {
            [xi.mod.REGAIN      ] = 150,
            [xi.mobMod.DETECTION] = xi.detects.HEARING,
        },

        isParty  = true,
        allDeath = function(battlefield, mob)
            npcUtil.showCrate(GetEntityByID(ID.npc.C3_LOOT_CRATE))
        end
    },

}

content.loot =
{
    [ID.npc.C3_LOOT_CRATE] =
    {
        {
            quantity = 4,
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.UTOPIAN_GOLD_THREAD,      weight = xi.loot.weight.NORMAL },
            { item = xi.item.CHUNK_OF_SNOWY_CERMET,    weight = xi.loot.weight.NORMAL },
            { item = xi.item.SPOOL_OF_SCARLET_ODOSHI,  weight = xi.loot.weight.NORMAL },
            { item = xi.item.SPOOL_OF_SILKWORM_THREAD, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,                      weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.SQUARE_OF_BENEDICT_SILK,   weight = xi.loot.weight.LOW       },
            { item = xi.item.SQUARE_OF_DIABOLIC_SILK,   weight = xi.loot.weight.LOW       },
            { item = xi.item.SPOOL_OF_RUBY_SILK_THREAD, weight = xi.loot.weight.LOW       },
            { item = xi.item.SQUARE_OF_BRILLIANTINE,    weight = xi.loot.weight.LOW       },
        },

        {
            { item = xi.item.NONE,                     weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.SPOOL_OF_COILED_YARN,     weight = xi.loot.weight.LOW       },
            { item = xi.item.SPOOL_OF_CHAMELEON_YARN,  weight = xi.loot.weight.LOW       },
            { item = xi.item.PLAITED_CORD,             weight = xi.loot.weight.LOW       },
            { item = xi.item.SPOOL_OF_LUMINIAN_THREAD, weight = xi.loot.weight.LOW       },
        },

        {
            { item = xi.item.NONE,                     weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.DARK_ORICHALCUM_INGOT,    weight = xi.loot.weight.LOW       },
            { item = xi.item.SPOOL_OF_GLITTERING_YARN, weight = xi.loot.weight.LOW       },
            { item = xi.item.SHEET_OF_COBALT_MYTHRIL,  weight = xi.loot.weight.LOW       },
            { item = xi.item.PANTIN_WIRE,              weight = xi.loot.weight.LOW       },
        },

        {
            { item = xi.item.SILVER_CHIP, weight = xi.loot.weight.NORMAL },
        },

        {
            { item = xi.item.NONE,       weight = xi.loot.weight.VERY_HIGH },
            { item = xi.item.METAL_CHIP, weight = xi.loot.weight.VERY_LOW  },
        },
    }
}

return content:register()
