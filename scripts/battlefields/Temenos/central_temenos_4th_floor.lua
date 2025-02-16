-----------------------------------
-- Area: Temenos
-- Name: Central Temenos 4th Floor
-- !additem silver_chip
-- !additem cerulean_chip
-- !additem orchid_chip
-- !addkeyitem white_card
-- !addkeyitem cosmo_cleanse
-- !pos 580.000 -2.375 104.000 37
-----------------------------------
local ID = zones[xi.zone.TEMENOS]
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.TEMENOS,
    battlefieldId    = xi.battlefield.id.CENTRAL_TEMENOS_4TH_FLOOR,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(60),
    index            = 3,
    area             = 4,
    entryNpc         = 'Matter_Diffusion_Module',
    requiredKeyItems = { xi.ki.COSMO_CLEANSE, xi.ki.WHITE_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    requiredItems    = { xi.item.SILVER_CHIP, xi.item.CERULEAN_CHIP, xi.item.ORCHID_CHIP },
    name             = 'CENTRAL_TEMENOS_4TH_FLOOR',
    lootCrateId      = ID.npc.C4_LOOT_CRATE,
})

local despawnGroupCrates = function(crateGroup)
    for i = 1, crateGroup.count do
        local crate = GetEntityByID(crateGroup.offset + i - 1)

        if crate and crate:getLocalVar('opened') == 0 then
            crate:setLocalVar('opened', 1)
            npcUtil.disappearCrate(crate)
        end
    end
end

function content:onBattlefieldInitialize(battlefield)
    Limbus.onBattlefieldInitialize(self, battlefield)

    -- Crates are always spawned with in fixed groups
    -- Randomize crate type order by shuffling setup functions
    for index, group in ipairs(ID.CENTRAL_TEMENOS_4TH_FLOOR.npc.GROUPS) do
        local itemIndex = math.random(1, group.count)

        for j = 1, group.count do
            local crateID = group.offset + j - 1
            local crate   = GetEntityByID(crateID)

            if crate then
                crate:setStatus(xi.status.NORMAL)
                crate:setUntargetable(false)
                crate:setAnimationSub(8)
                crate:setModelId(961)

                crate:addListener('ON_TRIGGER', 'TRIGGER_CRATE', function(player, npc)
                    npcUtil.openCrate(npc, function()
                        despawnGroupCrates(group)

                        if j == itemIndex then
                            content:handleLootRolls(player:getBattlefield(), content.loot[1], npc)
                        else
                            -- Spawn a random mob from the corresponding mob group
                            local mobGroup = ID.CENTRAL_TEMENOS_4TH_FLOOR.mob.GROUPS[index]
                            local mobID    = mobGroup.offset + math.random(0, mobGroup.count - 1)
                            local mob      = GetMobByID(mobID)

                            if mob then
                                mob:setSpawn(npc:getXPos(), npc:getYPos(), npc:getZPos(), npc:getRotPos())
                                mob:spawn()
                                mob:updateEnmity(player)
                            end
                        end
                    end)
                end)
            end
        end
    end
end

content.groups =
{
    {
        mobs  = { 'Armoury_Crate_Fourth' },
        setup = function(battlefield, crates)
            for _, crate in ipairs(crates) do
                crate:setBattleID(1) -- Different battle ID prevents the crate from being hit by AOEs
            end
        end
    },

    {
        mobs =
        {
            'Kingslayer_Doggvdegg',
            'JiGho_Ageless',
            'Koo_Buzu_the_Theomanic',
            'Yagudos_Elemental',
            'Yagudos_Avatar',
            'Mystic_Avatar_Ifrit',
            'Mystic_Avatar_Shiva',
            'Mystic_Avatar_Garuda',
            'Mystic_Avatar_Titan',
            'Mystic_Avatar_Ramuh',
            'Mystic_Avatar_Leviathan',
            'Enhanced_Koenigstiger',
            'Enhanced_Pygmaioi',
            'Enhanced_Kettenkaefer',
            'Enhanced_Salamander',
            'Enhanced_Jelly',
            'Enhanced_Makara',
            'Enhanced_Akbaba',
        },

        spawned = false,
    },

    {
        mobs =
        {
            'Kingslayer_Doggvdegg',
            'JiGho_Ageless',
            'Koo_Buzu_the_Theomanic',
        },

        spawned = false,
        mixins  = { require('scripts/mixins/job_special') }
    },

    {
        mobs  = { 'Proto-Ultima' },
        setup = function(battlefield, mobs)
            local ultima = mobs[1]

            -- Despawn all crates when Proto-Ultima is engaged
            ultima:addListener('ENGAGE', 'ULTIMA_ENGAGED', function(mob, target)
                for _, group in ipairs(ID.CENTRAL_TEMENOS_4TH_FLOOR.npc.GROUPS) do
                    despawnGroupCrates(group)
                end
            end)
        end,

        allDeath = function(battlefield, mob)
            local pos = mob:getSpawnPos()

            mob:setPos(pos.x, pos.y, pos.z, 64)
            xi.limbus.spawnFrom(mob, ID.npc.C4_LOOT_CRATE)
        end
    },
}

content.loot =
{
    [1] =
    {
        {
            quantity = 5,
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            quantity = 2,
            { item = xi.item.NONE,              weight = xi.loot.weight.NORMAL },
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            quantity = 2,
            { item = xi.item.SQUARE_OF_ECARLATE_CLOTH,  weight = xi.loot.weight.NORMAL },
            { item = xi.item.UTOPIAN_GOLD_THREAD,       weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_BENEDICT_SILK,   weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_DIABOLIC_SILK,   weight = xi.loot.weight.NORMAL },
            { item = xi.item.SPOOL_OF_RUBY_SILK_THREAD, weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_SUPPLE_SKIN,     weight = xi.loot.weight.NORMAL },
            { item = xi.item.CHUNK_OF_SNOWY_CERMET,     weight = xi.loot.weight.NORMAL },
            { item = xi.item.DARK_ORICHALCUM_INGOT,     weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_SMALT_LEATHER,   weight = xi.loot.weight.NORMAL },
            { item = xi.item.SPOOL_OF_COILED_YARN,      weight = xi.loot.weight.NORMAL },
            { item = xi.item.SPOOL_OF_CHAMELEON_YARN,   weight = xi.loot.weight.NORMAL },
            { item = xi.item.SPOOL_OF_SCARLET_ODOSHI,   weight = xi.loot.weight.NORMAL },
            { item = xi.item.PLAITED_CORD,              weight = xi.loot.weight.NORMAL },
            { item = xi.item.SHEET_OF_COBALT_MYTHRIL,   weight = xi.loot.weight.NORMAL },
            { item = xi.item.SPOOL_OF_GLITTERING_YARN,  weight = xi.loot.weight.NORMAL },
            { item = xi.item.SPOOL_OF_LUMINIAN_THREAD,  weight = xi.loot.weight.NORMAL },
            { item = xi.item.SPOOL_OF_SILKWORM_THREAD,  weight = xi.loot.weight.NORMAL },
            { item = xi.item.PANTIN_WIRE,               weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_FILET_LACE,      weight = xi.loot.weight.NORMAL },
            { item = xi.item.SQUARE_OF_BRILLIANTINE,    weight = xi.loot.weight.NORMAL },
        },
    },

    [ID.npc.C4_LOOT_CRATE] =
    {
        {
            quantity = 7,
            { item = xi.item.ANCIENT_BEASTCOIN, weight = xi.loot.weight.NORMAL },
        },

        {
            quantity = 2,
            { item = xi.item.PIECE_OF_ULTIMAS_CEREBRUM, weight = xi.loot.weight.NORMAL },
            { item = xi.item.SEGMENT_OF_ULTIMAS_CLAW,   weight = xi.loot.weight.LOW    },
            { item = xi.item.SEGMENT_OF_ULTIMAS_LEG,    weight = xi.loot.weight.LOW    },
            { item = xi.item.SEGMENT_OF_ULTIMAS_TAIL,   weight = xi.loot.weight.LOW    },
        },

        {
            { item = xi.item.NONE,                   weight = xi.loot.weight.EXTREMELY_HIGH },
            { item = xi.item.PIECE_OF_ULTIMAS_HEART, weight = xi.loot.weight.NORMAL         },
        },
    },
}

return content:register()
