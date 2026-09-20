-----------------------------------
-- Area: Temenos
-- Name: Central Temenos 1st Floor
-- !addkeyitem white_card
-- !addkeyitem cosmo_cleanse
-- !pos 580.000 -2.375 104.000 37
-----------------------------------
local ID = zones[xi.zone.TEMENOS]
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.TEMENOS,
    battlefieldId    = xi.battlefield.id.CENTRAL_TEMENOS_BASEMENT,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(15),
    index            = 7,
    area             = 8,
    entryNpc         = 'Matter_Diffusion_Module',
    requiredKeyItems = { xi.keyItem.COSMO_CLEANSE, xi.keyItem.WHITE_CARD, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    requiredItems    = { xi.item.METAL_CHIP },
    name             = 'CENTRAL_TEMENOS_BASEMENT',
    lootCrateId      = ID.npc.CB_LOOT_CRATE,
    timeExtension    = 5,
})

content.groups =
{
    {
        mobs =
        {
            'Temenos_Aern_WAR',
            'Temenos_Aern_MNK',
            'Temenos_Aern_WHM',
            'Temenos_Aern_BLM',
            'Temenos_Aern_RDM',
            'Temenos_Aern_THF',
            'Temenos_Aern_PLD',
            'Temenos_Aern_DRK',
            'Temenos_Aern_BST',
            'Temenos_Aern_BRD',
            'Temenos_Aern_RNG',
            'Temenos_Aern_SAM',
            'Temenos_Aern_NIN',
            'Temenos_Aern_DRG',
            'Temenos_Aern_SMN',
        },

        isParty = true,
        mobMods = { [xi.mobMod.DETECTION] = xi.detects.HEARING },
        mixins =
        {
            require('scripts/mixins/families/aern'),
            require('scripts/mixins/job_special'),
        },

        setup = function(battlefield, mobs)
            local remainingAern = #mobs

            for _, mob in ipairs(mobs) do
                mob:setLocalVar('ALLOW_DROPS', 1)
                mob:setLocalVar('AERN_RERAISE_MAX', 5)
                mob:removeListener('DESPAWN_AERN_TIME')

                -- When the last Aern despawns then spawn the Temenos Ghrah
                mob:addListener('DESPAWN', 'DESPAWN_AERN_GHRAH', function(mobArg)
                    remainingAern = remainingAern - 1

                    if remainingAern <= 0 then
                        local boss = mob:getZone():queryEntitiesByName('Temenos_Ghrah')[1]
                        boss:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
                        boss:spawn()
                    end
                end)

                mob:addListener('ITEM_DROPS', 'ITEM_DROPS_AERN', function(mobArg, loot)
                    local quantity = math.min(3, mob:getLocalVar('AERN_RERAISES'))

                    loot:addItem(xi.item.ANCIENT_BEASTCOIN, xi.drop_rate.GUARANTEED, quantity)
                end)
            end

            local aernByID = {}

            for _, mob in ipairs(mobs) do
                aernByID[mob:getID()] = mob
            end

            -- Aern are split into rooms and 6 of the 10 random rooms are assigned a time extension to a random member
            local aernID = ID.CENTRAL_TEMENOS_BASEMENT.mob.BASEMENT_AERN
            local rooms =
            {
                { aernID +  0, aernID +  1 },                                        -- Bottom-right room: SAM MNK
                { aernID +  2, aernID +  4 },                                        -- Bottom-left room: DRG WHM
                { aernID +  5, aernID +  7 },                                        -- Lower-center-right room: RDM BST
                { aernID +  8, aernID +  9 },                                        -- Lower-center-left room: NIN DRK
                { aernID + 10, aernID + 11 },                                        -- Mid-right room: WAR BLM
                { aernID + 12, aernID + 13 },                                        -- Mid-left room: WAR SMN
                { aernID + 16, aernID + 18, aernID + 19 },                           -- Top-right room: DRG WHM BLM
                { aernID + 20, aernID + 22, aernID + 23 },                           -- Top-left room: BST RNG SAM
                { aernID + 24, aernID + 25, aernID + 26, aernID + 29 },              -- Center room: RDM PLD SMN THF
                { aernID + 30, aernID + 31, aernID + 32, aernID + 33, aernID + 34 }, -- Top-center room: MNK DRK BRD NIN WAR
            }

            rooms = utils.shuffle(rooms)

            for i = 1, 6, 1 do
                local room = rooms[i]
                local mob  = aernByID[room[math.random(1, #room)]]

                -- Award time extension once the aern fully despawns and is no longer reraising
                mob:addListener('DESPAWN', 'DESPAWN_AERN_TIME', function(mobArg)
                    local mobBattlefield = mob:getBattlefield()

                    if mobBattlefield then
                        content:extendTimeLimit(ID, mobBattlefield)
                    end
                end)
            end
        end,
    },

    {
        spawned = false,
        mobs    = { 'Aerns_Avatar' },
        mixins  = { require('scripts/mixins/families/avatar') },
    },

    {
        spawned = false,
        mobs =
        {
            'Aerns_Wynav',
            'Aerns_Euvhi',
            'Aerns_Elemental',
        },
    },

    {
        mobs    = { 'Temenos_Ghrah' },
        spawned = false,
        death   = function(battlefield, mob, count)
            npcUtil.showCrate(GetNPCByID(ID.npc.CB_LOOT_CRATE))
        end,
    }
}

content.loot =
{
    [ID.npc.CB_LOOT_CRATE] =
    {
        {
            quantity = 7,
            { itemId = xi.item.ANCIENT_BEASTCOIN, weight = 1000 },
        },

        {
            { itemId = xi.item.NONE,       weight = xi.loot.weight.VERY_HIGH },
            { itemId = xi.item.METAL_CHIP, weight = xi.loot.weight.NORMAL    },
        },
    }
}

return content:register()
