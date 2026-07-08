-----------------------------------
-- Mimeo Stone
-----------------------------------
-- Luminant : !pos 241.833 19.009 -152.072
-- Luminant : !pos 444.687 19.697 -172.114
-- Luminant : !pos 514.630 19.328 -79.209
-- Luminant : !pos 275.930 19.229 153.760
-- Luminant : !pos 197.387 19.977 -56.561
-- Luminant : !pos 442.997 19.500 -34.534
-- Cradle of Rebirth : !pos 319.958 -25.652 -11.895
-----------------------------------

local quest = HiddenQuest:new('mimeoStone')
local ID = zones[xi.zone.ATTOHWA_CHASM]
local attohwaChasmGlobal = require('scripts/zones/Attohwa_Chasm/globals')

local rewards =
{
    [0] = xi.item.REGAIN_FEATHER,
    [1] = xi.item.REBIRTH_FEATHER,
    [2] = xi.item.REVIVE_FEATHER,
    [3] = xi.item.BLAZE_FEATHER,
    [4] = xi.item.FIRE_FEATHER
}

local stoneTimer
stoneTimer = function(player)
    -- Once the animation at the Cradle has started, the reward has already been locked in
    -- so don't continue the timer after this point
    if
        not player or
        not player:hasKeyItem(xi.ki.MIMEO_STONE) or
        quest:getLocalVar(player, 'Progress') == 1
    then
        return
    end

    local numFades = quest:getLocalVar(player, 'NumFades') + 1
    if numFades == 5 then
        player:messageSpecial(ID.text.MIMEO_JEWEL_OFFSET + 4, xi.ki.MIMEO_STONE)
        player:delKeyItem(xi.ki.MIMEO_STONE)
        return
    end

    quest:setLocalVar(player, 'NumFades', numFades)

    player:messageSpecial(ID.text.MIMEO_JEWEL_OFFSET + numFades - 1, xi.ki.MIMEO_STONE)

    -- Captures show ranges from 49 to 88, but it may not necessarily be purely random
    -- For Luminant Offset+3, all times (12 recorded) were below 60s except 1
    -- For all other Luminants, there were no times below 60s (14 recorded)
    -- There could be some subtle differences based on the Luminant distance to the Cradle,
    -- but unless we get a hundred more times captured this is probably the best we can do.
    player:timer(math.randomInt(50, 90) * 1000, function()
        stoneTimer(player)
    end)
end

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return not player:hasKeyItem(xi.ki.MIMEO_STONE)
        end,

        [xi.zone.ATTOHWA_CHASM] =
        {
            ['Luminant'] =
            {
                onTrigger = function(player, npc, trade)
                    npcUtil.giveKeyItem(player, xi.ki.MIMEO_STONE)
                    player:messageSpecial(ID.text.MIMEO_STONE_PICKUP, xi.ki.MIMEO_STONE)

                    attohwaChasmGlobal.handleLuminantUsed(npc)

                    quest:setLocalVar(player, 'NumFades', 0)
                    quest:setLocalVar(player, 'Progress', 0)

                    player:timer(math.randomInt(50, 90) * 1000, function()
                        stoneTimer(player)
                    end)
                end,
            },
        },
    },

    {
        check = function(player, questVars, vars)
            return player:hasKeyItem(xi.ki.MIMEO_STONE)
        end,

        [xi.zone.ATTOHWA_CHASM] =
        {
            ['Luminant'] =
            {
                onTrigger = function(player, npc)
                    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
                end
            },

            ['Cradle_of_Rebirth'] =
            {
                onTrigger = function(player, npc)
                    if
                        player:hasKeyItem(xi.ki.MIMEO_STONE) and
                        quest:getLocalVar(player, 'Progress') == 0
                    then
                        local numFades = quest:getLocalVar(player, 'NumFades')
                        player:messageSpecial(ID.text.MIMEO_STONE_BRIGHTNESS_OFFSET + numFades, xi.ki.MIMEO_STONE)

                        -- Make sure player has room for reward, otherwise timer keeps running
                        local reward = rewards[numFades]
                        if player:hasItem(reward) then
                            player:messageSpecial(ID.text.CANNOT_OBTAIN_ITEM, reward)
                            return quest:noAction()
                        end

                        local animationNpc = GetNPCByID(npc:getID() + 1)
                        if animationNpc then
                            animationNpc:entityAnimationPacket('krtu')
                        end

                        quest:setLocalVar(player, 'Progress', 1)
                        return quest:progressEvent(2)
                    end
                end,
            },

            onZoneOut = function(player)
                player:messageSpecial(ID.text.MIMEO_JEWEL_OFFSET + 4, xi.ki.MIMEO_STONE)
                player:delKeyItem(xi.ki.MIMEO_STONE)
            end,

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    player:delKeyItem(xi.ki.MIMEO_STONE)
                    local numFades = quest:getLocalVar(player, 'NumFades')
                    npcUtil.giveItem(player, rewards[numFades])
                end,
            },
        },
    },
}

return quest
