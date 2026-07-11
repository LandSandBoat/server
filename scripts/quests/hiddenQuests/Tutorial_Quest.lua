-----------------------------------
-- Tutorial Mini-Quest
-----------------------------------
local quest = HiddenQuest:new('Tutorial')

local function hasLearntWeaponskill(player)
    for skillId = xi.skill.HAND_TO_HAND, xi.skill.STAFF do
        if player:getSkillLevel(skillId) >= 5 then
            return true
        end
    end

    return false
end

quest.sections =
{
    -- Step 0 -> Introduction.
    {
        check = function(player, questVars, vars)
            return questVars.Prog == 0
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Gulldago'] = quest:progressEvent(719),

            onEventFinish =
            {
                [719] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Alaune'] = quest:progressEvent(3662),

            onEventFinish =
            {
                [3662] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Selele'] = quest:progressEvent(1010),

            onEventFinish =
            {
                [1010] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },
    },

    -- Step 1 -> Instruct to get Signet.
    {
        check = function(player, questVars, vars)
            return questVars.Prog == 1
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Gulldago'] = quest:progressEvent(697),

            onEventFinish =
            {
                [697] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Alaune'] = quest:progressEvent(3640),

            onEventFinish =
            {
                [3640] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Selele'] = quest:progressEvent(988),

            onEventFinish =
            {
                [988] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,
            },
        },
    },

    -- Step 2 -> Talk to NPC after getting Signet (Reward: Meat Jerky x6.). Instruct to eat.
    {
        check = function(player, questVars, vars)
            return questVars.Prog == 2
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Gulldago'] =
            {
                onTrigger = function(player, npc)
                    if player:hasStatusEffect(xi.effect.SIGNET) then
                        return quest:progressEvent(699)
                    else
                        return quest:event(698)
                    end
                end,
            },

            onEventFinish =
            {
                [699] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, { { xi.item.STRIP_OF_MEAT_JERKY, 6 } }) then
                        quest:setVar(player, 'Prog', 3)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Alaune'] =
            {
                onTrigger = function(player, npc)
                    if player:hasStatusEffect(xi.effect.SIGNET) then
                        return quest:progressEvent(3642)
                    else
                        return quest:event(3641)
                    end
                end,
            },

            onEventFinish =
            {
                [3642] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, { { xi.item.STRIP_OF_MEAT_JERKY, 6 } }) then
                        quest:setVar(player, 'Prog', 3)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Selele'] =
            {
                onTrigger = function(player, npc)
                    if player:hasStatusEffect(xi.effect.SIGNET) then
                        return quest:progressEvent(990)
                    else
                        return quest:event(989)
                    end
                end,
            },

            onEventFinish =
            {
                [990] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, { { xi.item.STRIP_OF_MEAT_JERKY, 6 } }) then
                        quest:setVar(player, 'Prog', 3)
                    end
                end,
            },
        },
    },

    -- Step 3 -> Talk to NPC after having eaten. Instruct to learn a weaponskill.
    {
        check = function(player, questVars, vars)
            return questVars.Prog == 3
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Gulldago'] =
            {
                onTrigger = function(player, npc)
                    if player:hasStatusEffect(xi.effect.FOOD) then
                        return quest:progressEvent(701)
                    else
                        return quest:event(700)
                    end
                end,
            },

            onEventFinish =
            {
                [701] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Alaune'] =
            {
                onTrigger = function(player, npc)
                    if player:hasStatusEffect(xi.effect.FOOD) then
                        return quest:progressEvent(3644)
                    else
                        return quest:event(3643)
                    end
                end,
            },

            onEventFinish =
            {
                [3644] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Selele'] =
            {
                onTrigger = function(player, npc)
                    if player:hasStatusEffect(xi.effect.FOOD) then
                        return quest:progressEvent(992)
                    else
                        return quest:event(991)
                    end
                end,
            },

            onEventFinish =
            {
                [992] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
                end,
            },
        },
    },

    -- Step 4 -> Talk to NPC after learning a Weaponskill (Reward: 100 gil). Instruct to activate Records of Eminence. NOTE: Retail does NOT check for weaponskill usage.
    {
        check = function(player, questVars, vars)
            return questVars.Prog == 4
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Gulldago'] =
            {
                onTrigger = function(player, npc)
                    if hasLearntWeaponskill(player) then
                        return quest:progressEvent(703)
                    else
                        return quest:event(702)
                    end
                end,
            },

            onEventFinish =
            {
                [703] = function(player, csid, option, npc)
                    npcUtil.giveCurrency(player, 'gil', 100 * xi.settings.main.GIL_RATE)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Alaune'] =
            {
                onTrigger = function(player, npc)
                    if hasLearntWeaponskill(player) then
                        return quest:progressEvent(3646)
                    else
                        return quest:event(3645)
                    end
                end,
            },

            onEventFinish =
            {
                [3646] = function(player, csid, option, npc)
                    npcUtil.giveCurrency(player, 'gil', 100 * xi.settings.main.GIL_RATE)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Selele'] =
            {
                onTrigger = function(player, npc)
                    if hasLearntWeaponskill(player) then
                        return quest:progressEvent(994)
                    else
                        return quest:event(993)
                    end
                end,
            },

            onEventFinish =
            {
                [994] = function(player, csid, option, npc)
                    npcUtil.giveCurrency(player, 'gil', 100 * xi.settings.main.GIL_RATE)
                    quest:setVar(player, 'Prog', 5)
                end,
            },
        },
    },

    -- Step 5 -> Talk to NPC after getting Memorandoll (Reward: Crystal and 2 items). Instruct to check the AH.
    {
        check = function(player, questVars, vars)
            return questVars.Prog == 5
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Gulldago'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.MEMORANDOLL) then
                        return quest:progressEvent(705)
                    else
                        return quest:event(704)
                    end
                end,
            },

            onEventFinish =
            {
                [705] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, { { xi.item.LIZARD_TAIL, 1 }, { xi.item.POT_OF_HONEY, 1 }, { xi.item.FIRE_CRYSTAL, 1 } }) then
                        quest:setVar(player, 'Prog', 6)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Alaune'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.MEMORANDOLL) then
                        return quest:progressEvent(3648)
                    else
                        return quest:event(3647)
                    end
                end,
            },

            onEventFinish =
            {
                [3648] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, { { xi.item.CHUNK_OF_ROCK_SALT, 1 }, { xi.item.SLICE_OF_HARE_MEAT, 1 }, { xi.item.FIRE_CRYSTAL, 1 } }) then
                        quest:setVar(player, 'Prog', 6)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Selele'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.MEMORANDOLL) then
                        return quest:progressEvent(996)
                    else
                        return quest:event(995)
                    end
                end,
            },

            onEventFinish =
            {
                [996] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, { { xi.item.BIRD_EGG, 1 }, { xi.item.POT_OF_HONEY, 1 }, { xi.item.WATER_CRYSTAL, 1 } }) then
                        quest:setVar(player, 'Prog', 6)
                    end
                end,
            },
        },
    },

    -- Step 6 -> Talk to NPC after checking the AH (Reward: Conquest promotion voucher). Instruct to reach level 5.
    {
        check = function(player, questVars, vars)
            return questVars.Prog == 6
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Auction_Counter'] =
            {
                onTrigger = function(player, npc)
                    quest:setVar(player, 'Option', 1)
                    player:sendMenu(xi.menuType.AUCTION)
                    return quest:noAction()
                end,
            },
        },

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Auction_Counter'] =
            {
                onTrigger = function(player, npc)
                    quest:setVar(player, 'Option', 1)
                    player:sendMenu(xi.menuType.AUCTION)
                    return quest:noAction()
                end,
            },

            ['Gulldago'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 1 then
                        return quest:progressEvent(707)
                    else
                        return quest:event(706)
                    end
                end,
            },

            onEventFinish =
            {
                [707] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.CONQUEST_PROMOTION_VOUCHER)
                    quest:setVar(player, 'Prog', 7)
                    quest:setVar(player, 'Option', 0)
                end,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Auction_Counter'] =
            {
                onTrigger = function(player, npc)
                    quest:setVar(player, 'Option', 1)
                    player:sendMenu(xi.menuType.AUCTION)
                    return quest:noAction()
                end,
            },
        },

        [xi.zone.EASTERN_ADOULIN] =
        {
            ['Auction_Counter'] =
            {
                onTrigger = function(player, npc)
                    quest:setVar(player, 'Option', 1)
                    player:sendMenu(xi.menuType.AUCTION)
                    return quest:noAction()
                end,
            },
        },

        [xi.zone.LOWER_JEUNO] =
        {
            ['Auction_Counter'] =
            {
                onTrigger = function(player, npc)
                    quest:setVar(player, 'Option', 1)
                    player:sendMenu(xi.menuType.AUCTION)
                    return quest:noAction()
                end,
            },
        },

        [xi.zone.PORT_SAN_DORIA] =
        {
            ['Auction_Counter'] =
            {
                onTrigger = function(player, npc)
                    quest:setVar(player, 'Option', 1)
                    player:sendMenu(xi.menuType.AUCTION)
                    return quest:noAction()
                end,
            },
        },

        [xi.zone.RULUDE_GARDENS] =
        {
            ['Auction_Counter'] =
            {
                onTrigger = function(player, npc)
                    quest:setVar(player, 'Option', 1)
                    player:sendMenu(xi.menuType.AUCTION)
                    return quest:noAction()
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Auction_Counter'] =
            {
                onTrigger = function(player, npc)
                    quest:setVar(player, 'Option', 1)
                    player:sendMenu(xi.menuType.AUCTION)
                    return quest:noAction()
                end,
            },

            ['Alaune'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 1 then
                        return quest:progressEvent(3650)
                    else
                        return quest:event(3649)
                    end
                end,
            },

            onEventFinish =
            {
                [3650] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.CONQUEST_PROMOTION_VOUCHER)
                    quest:setVar(player, 'Prog', 7)
                    quest:setVar(player, 'Option', 0)
                end,
            },
        },

        [xi.zone.WESTERN_ADOULIN] =
        {
            ['Auction_Counter'] =
            {
                onTrigger = function(player, npc)
                    quest:setVar(player, 'Option', 1)
                    player:sendMenu(xi.menuType.AUCTION)
                    return quest:noAction()
                end,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            ['Auction_Counter'] =
            {
                onTrigger = function(player, npc)
                    quest:setVar(player, 'Option', 1)
                    player:sendMenu(xi.menuType.AUCTION)
                    return quest:noAction()
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Auction_Counter'] =
            {
                onTrigger = function(player, npc)
                    quest:setVar(player, 'Option', 1)
                    player:sendMenu(xi.menuType.AUCTION)
                    return quest:noAction()
                end,
            },

            ['Selele'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Option') == 1 then
                        return quest:progressEvent(998)
                    else
                        return quest:event(997)
                    end
                end
            },

            onEventFinish =
            {
                [998] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.CONQUEST_PROMOTION_VOUCHER)
                    quest:setVar(player, 'Prog', 7)
                    quest:setVar(player, 'Option', 0)
                end,
            },
        },
    },

    -- Step 7 -> Talk to NPC after reaching level 5 (Reward: Raising Earring). Instruct to get nation's trust permit.
    {
        check = function(player, questVars, vars)
            return questVars.Prog == 7
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Gulldago'] =
            {
                onTrigger = function(player, npc)
                    if player:getMainLvl() >= 5 then
                        return quest:progressEvent(709)
                    else
                        return quest:event(708)
                    end
                end,
            },

            onEventFinish =
            {
                [709] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.RAISING_EARRING) then
                        quest:setVar(player, 'Prog', 8)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Alaune'] =
            {
                onTrigger = function(player, npc)
                    if player:getMainLvl() >= 5 then
                        return quest:progressEvent(3652)
                    else
                        return quest:event(3651)
                    end
                end,
            },

            onEventFinish =
            {
                [3652] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.RAISING_EARRING) then
                        quest:setVar(player, 'Prog', 8)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Selele'] =
            {
                onTrigger = function(player, npc)
                    if player:getMainLvl() >= 5 then
                        return quest:progressEvent(1000)
                    else
                        return quest:event(999)
                    end
                end,
            },

            onEventFinish =
            {
                [1000] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.RAISING_EARRING) then
                        quest:setVar(player, 'Prog', 8)
                    end
                end,
            },
        },
    },

    -- Step 8 -> Talk to NPC after getting nation trust permit (Reward: Warp Ring). Instruct to use Survival guide.
    {
        check = function(player, questVars, vars)
            return questVars.Prog == 8
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Gulldago'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.BASTOK_TRUST_PERMIT) then
                        return quest:progressEvent(711)
                    else
                        return quest:event(710)
                    end
                end,
            },

            onEventFinish =
            {
                [711] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.WARP_RING) then
                        quest:setVar(player, 'Prog', 9)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Alaune'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SAN_DORIA_TRUST_PERMIT) then
                        return quest:progressEvent(3654)
                    else
                        return quest:event(3653)
                    end
                end,
            },

            onEventFinish =
            {
                [3654] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.WARP_RING) then
                        quest:setVar(player, 'Prog', 9)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Selele'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.WINDURST_TRUST_PERMIT) then
                        return quest:progressEvent(1002)
                    else
                        return quest:event(1001)
                    end
                end,
            },

            onEventFinish =
            {
                [1002] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.WARP_RING) then
                        quest:setVar(player, 'Prog', 9)
                    end
                end,
            },
        },
    },

    -- Step 9 -> Talk to NPC after checking Survival guides in order (Reward: Saltena x12). Instruct to reach level 18. NOTE: Retail only cares for checking the survival guide in city and in outpost.
    {
        check = function(player, questVars, vars)
            return questVars.Prog == 9
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Gulldago'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar('TutorialBypass') >= 2 then
                        return quest:progressEvent(713, xi.nation.BASTOK)
                    else
                        return quest:event(712, xi.nation.BASTOK)
                    end
                end,
            },

            onEventFinish =
            {
                [713] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, { { xi.item.SALTENA, 12 } }) then
                        quest:setVar(player, 'Prog', 10)
                        player:setCharVar('TutorialBypass', 0)
                    end
                end,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Survival_Guide'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar('TutorialBypass') == 0 then
                        player:setCharVar('TutorialBypass', 1)
                        return xi.survivalGuide.onTrigger(player)
                    end
                end,
            },
        },

        [xi.zone.NORTH_GUSTABERG] =
        {
            ['Survival_Guide'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar('TutorialBypass') == 1 then
                        player:setCharVar('TutorialBypass', 2)
                        return xi.survivalGuide.onTrigger(player)
                    end
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Survival_Guide'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar('TutorialBypass') == 0 then
                        player:setCharVar('TutorialBypass', 1)
                        return xi.survivalGuide.onTrigger(player)
                    end
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Survival_Guide'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar('TutorialBypass') == 0 then
                        player:setCharVar('TutorialBypass', 1)
                        return xi.survivalGuide.onTrigger(player)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Alaune'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar('TutorialBypass') >= 2 then
                        return quest:progressEvent(3656, xi.nation.SANDORIA)
                    else
                        return quest:event(3655, xi.nation.SANDORIA)
                    end
                end,
            },

            onEventFinish =
            {
                [3656] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, { { xi.item.SALTENA, 12 } }) then
                        quest:setVar(player, 'Prog', 10)
                        player:setCharVar('TutorialBypass', 0)
                    end
                end,
            },
        },

        [xi.zone.WEST_RONFAURE] =
        {
            ['Survival_Guide'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar('TutorialBypass') == 1 then
                        player:setCharVar('TutorialBypass', 2)
                        return xi.survivalGuide.onTrigger(player)
                    end
                end,
            },
        },

        [xi.zone.WEST_SARUTABARUTA] =
        {
            ['Survival_Guide'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar('TutorialBypass') == 1 then
                        player:setCharVar('TutorialBypass', 2)
                        return xi.survivalGuide.onTrigger(player)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Selele'] =
            {
                onTrigger = function(player, npc)
                    if player:getCharVar('TutorialBypass') >= 2 then
                        return quest:progressEvent(1004, xi.nation.WINDURST)
                    else
                        return quest:event(1003, xi.nation.WINDURST)
                    end
                end,
            },

            onEventFinish =
            {
                [1004] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, { { xi.item.SALTENA, 12 } }) then
                        quest:setVar(player, 'Prog', 10)
                        player:setCharVar('TutorialBypass', 0)
                    end
                end,
            },
        },
    },

    -- Step 10 -> Talk to NPC after reaching level 18 (Reward: Copper A.M.A.N. Voucher). Instruct to get and set a subjob.
    {
        check = function(player, questVars, vars)
            return questVars.Prog == 10
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Gulldago'] =
            {
                onTrigger = function(player, npc)
                    if player:getMainLvl() >= 18 then
                        return quest:progressEvent(715, xi.nation.BASTOK)
                    else
                        return quest:event(714)
                    end
                end,
            },

            onEventFinish =
            {
                [715] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.COPPER_AMAN_VOUCHER) then
                        quest:setVar(player, 'Prog', 11)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Alaune'] =
            {
                onTrigger = function(player, npc)
                    if player:getMainLvl() >= 18 then
                        return quest:progressEvent(3658, xi.nation.SANDORIA)
                    else
                        return quest:event(3657)
                    end
                end,
            },

            onEventFinish =
            {
                [3658] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.COPPER_AMAN_VOUCHER) then
                        quest:setVar(player, 'Prog', 11)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Selele'] =
            {
                onTrigger = function(player, npc)
                    if player:getMainLvl() >= 18 then
                        return quest:progressEvent(1006, xi.nation.WINDURST)
                    else
                        return quest:event(1005)
                    end
                end,
            },

            onEventFinish =
            {
                [1006] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.item.COPPER_AMAN_VOUCHER) then
                        quest:setVar(player, 'Prog', 11)
                    end
                end,
            },
        },
    },

    -- Step 11 -> Talk to NPC after setting a subjob (Reward: Chocopass x12, Echad Ring).
    {
        check = function(player, questVars, vars)
            return questVars.Prog == 11
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Gulldago'] =
            {
                onTrigger = function(player, npc)
                    if player:getSubLvl() >= 1 then
                        return quest:progressEvent(717)
                    else
                        return quest:event(716, xi.nation.BASTOK)
                    end
                end,
            },

            onEventFinish =
            {
                [717] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, { { xi.item.FREE_CHOCOPASS, 12 }, { xi.item.ECHAD_RING, 1 } }) then
                        quest:setVar(player, 'Prog', 12)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Alaune'] =
            {
                onTrigger = function(player, npc)
                    if player:getSubLvl() >= 1 then
                        return quest:progressEvent(3660)
                    else
                        return quest:event(3659, xi.nation.SANDORIA)
                    end
                end,
            },

            onEventFinish =
            {
                [3660] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, { { xi.item.FREE_CHOCOPASS, 12 }, { xi.item.ECHAD_RING, 1 } }) then
                        quest:setVar(player, 'Prog', 12)
                    end
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Selele'] =
            {
                onTrigger = function(player, npc)
                    if player:getSubLvl() >= 1 then
                        return quest:progressEvent(1008)
                    else
                        return quest:event(1007, xi.nation.WINDURST)
                    end
                end,
            },

            onEventFinish =
            {
                [1008] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, { { xi.item.FREE_CHOCOPASS, 12 }, { xi.item.ECHAD_RING, 1 } }) then
                        quest:setVar(player, 'Prog', 12)
                    end
                end,
            },
        },
    },

    -- Default dialog after completing tutorial.
    {
        check = function(player, questVars, vars)
            return questVars.Prog == 12
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Gulldago'] = quest:event(718),
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Alaune'] = quest:event(3661),
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Selele'] = quest:event(1009),
        },
    },
}

return quest
