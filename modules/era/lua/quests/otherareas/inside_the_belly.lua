-----------------------------------
-- Inside the Belly
-- Restores Zaldon's trade list to the era of the newest enabled expansion.
-- The quest launched with 18 fish. Version updates from 2009-11-10 onward grew the list.
-- Each batch is gated on when the trade option was added, not on when its fish was implemented.
--
-- Source: https://www.playonline.com/pcd/verup/ff11/detail/5053/detail.html
-- Source: https://wiki.ffo.jp/html/1338.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_quest_inside_the_belly',
    xi.pre(xi.expansion.WOTG) or
    xi.pre(xi.expansion.ABYSSEA) or
    xi.pre(xi.expansion.SOA) or
    xi.pre(xi.expansion.ROV))

local tradeBatches =
{
    -- Added 2009-11-10 and 2010-03-23.
    {
        blocked = xi.pre(xi.expansion.WOTG),
        items =
        {
            xi.item.BLADEFISH_1,
            xi.item.GAVIAL_FISH,
            xi.item.VEYDAL_WRASSE_1,
            xi.item.MORINABALIGI,
            xi.item.TURNABALIGI,
            xi.item.KALKANBALIGI,
            xi.item.PTERYGOTUS,
            xi.item.GERROTHORAX,
            xi.item.PIRARUCU,
            xi.item.MEGALODON,
            xi.item.YAYINBALIGI,
            xi.item.LAKERDA,
            xi.item.KILICBALIGI,
            xi.item.MONKE_ONKE_1,
            xi.item.AHTAPOT,
            xi.item.ARMORED_PISCES,
            xi.item.MOLA_MOLA,
        },
    },

    -- Added 2010-09-09 and 2010-12-07.
    {
        blocked = xi.pre(xi.expansion.ABYSSEA),
        items =
        {
            xi.item.GUGRU_TUNA_1,
            xi.item.ISTAVRIT_1,
            xi.item.GIGANT_OCTOPUS_1,
            xi.item.THREE_EYED_FISH_1,
            xi.item.GIGANT_SQUID,
            xi.item.RHINOCHIMERA_1,
            xi.item.GRIMMONITE,
            xi.item.TITANIC_SAWFISH,
            xi.item.PELAZOEA,
            xi.item.DORADO_GAR,
            xi.item.CROCODILOS,
        },
    },

    -- Added 2012-07-24, between Abyssea and SoA.
    {
        blocked = xi.pre(xi.expansion.SOA),
        items =
        {
            xi.item.ABAIA,
            xi.item.MATSYA,
        },
    },

    -- Added 2015-06-25 and 2015-11-10.
    {
        blocked = xi.pre(xi.expansion.ROV),
        items =
        {
            xi.item.SORYU,
            xi.item.SEKIRYU,
            xi.item.HAKURYU,
            xi.item.FAR_EAST_PUFFER,
        },
    },
}

local blockedFish = {}
for _, batch in ipairs(tradeBatches) do
    if batch.blocked then
        for _, itemId in ipairs(batch.items) do
            blockedFish[itemId] = true
        end
    end
end

m:addOverride('xi.server.onServerStart', function()
    super()

    xi.module.modifyInteractionEntry('scripts/quests/otherAreas/Inside_the_Belly', function(quest)
        -- Sections 2 and 3 take the fish trades (quest accepted and quest completed).
        for _, sectionIdx in ipairs({ 2, 3 }) do
            local zaldon      = quest.sections[sectionIdx][xi.zone.SELBINA]['Zaldon']
            local baseOnTrade = zaldon.onTrade

            -- A blocked fish returns nothing. Zaldon plays his default dialogue and the fish is kept.
            zaldon.onTrade = function(player, npc, trade)
                for itemSlot = 0, trade:getSlotCount() - 1 do
                    if blockedFish[trade:getItemId(itemSlot)] then
                        return
                    end
                end

                return baseOnTrade(player, npc, trade)
            end

            -- The stock hint lists name only original and 2009-batch fish.
            -- Events 163, 164, and 165 render a fixed count of names (5, 2+4, 2+6). An empty slot prints a blank name.
            if xi.pre(xi.expansion.WOTG) then
                zaldon.onTrigger = function(player, npc)
                    local fishingSkill = xi.crafting.getTotalSkill(player, xi.skill.FISHING)

                    local tier = 4

                    if fishingSkill < 40 then
                        tier = 1
                    elseif fishingSkill < 50 then
                        tier = 2
                    elseif fishingSkill < 75 then
                        tier = 3
                    end

                    local csTier =
                    {
                        {
                            162,
                            xi.item.GIANT_CATFISH_1,
                            xi.item.DARK_BASS_1,
                            xi.item.OGRE_EEL_1,
                            xi.item.ZAFMLUG_BASS,
                        },

                        {
                            163,
                            xi.item.ZAFMLUG_BASS,
                            xi.item.GIANT_DONKO_1,
                            xi.item.BHEFHEL_MARLIN_1,
                            xi.item.JUNGLE_CATFISH,
                            xi.item.SILVER_SHARK,
                        },

                        {
                            164,
                            xi.item.JUNGLE_CATFISH,
                            xi.item.EMPEROR_FISH,
                            xi.item.SILVER_SHARK,
                            xi.item.TAKITARO,
                            xi.item.SEA_ZOMBIE,
                            xi.item.GIANT_CHIRAI,
                        },

                        {
                            165,
                            xi.item.TAKITARO,
                            xi.item.SEA_ZOMBIE,
                            xi.item.TITANICTUS,
                            xi.item.CAVE_CHERAX,
                            xi.item.TRICORN,
                            xi.item.RYUGU_TITAN,
                            xi.item.LIK,
                            xi.item.GUGRUSAURUS,
                        },
                    }

                    return quest:event(unpack(csTier[tier]))
                end
            end
        end
    end)
end)
