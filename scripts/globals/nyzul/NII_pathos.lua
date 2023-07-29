-----------------------------------
-- Nyzul Isle Global
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/utils")
-----------------------------------
xi = xi or {}
xi.nyzul = xi.nyzul or {}
-----------------------------------

xi.nyzul.pathosList =
{
    -- Found info:
    -- If gaining pathos from failed gear objectives, it will pick 3 different ways,
    -- 1. Token reward reduction.
    -- 2. Time reduction.
    -- 3. Random any other effect.
    -- Once picked which of the 3 chioces for the floor, it will always be that for each occurance in said floor.

    -- Negative Effects.
    [1]  = { effect = xi.effect.IMPAIRMENT,    power = 0x01,  textId = ID.text.RESTRICTION_JOB_ABILITIES     }, -- Job Abilities
    [2]  = { effect = xi.effect.IMPAIRMENT,    power = 0x02,  textId = ID.text.RESTRICTION_WEAPON_SKILLS     }, -- Weapon Skills
    [3]  = { effect = xi.effect.OMERTA,        power = 0x01,  textId = ID.text.RESTRICTION_SONGS             }, -- Songs
    [4]  = { effect = xi.effect.OMERTA,        power = 0x02,  textId = ID.text.RESTRICTION_BLACK_MAGIC       }, -- Black Magic
    [5]  = { effect = xi.effect.OMERTA,        power = 0x04,  textId = ID.text.RESTRICTION_BLUE_MAGIC        }, -- Blue Magic
    [6]  = { effect = xi.effect.OMERTA,        power = 0x08,  textId = ID.text.RESTRICTION_NINJITSU          }, -- Ninjutsu
    [7]  = { effect = xi.effect.OMERTA,        power = 0x10,  textId = ID.text.RESTRICTION_SUMMON_MAGIC      }, -- Summoning Magic
    [8]  = { effect = xi.effect.OMERTA,        power = 0x20,  textId = ID.text.RESTRICTION_WHITE_MAGIC       }, -- White Magic
    [9]  = { effect = xi.effect.SLOW,          power = 2000,  textId = ID.text.AFFLICTION_ATTACK_SPEED_DOWN  }, -- Attack speed reduced, needs retail data
    [10] = { effect = xi.effect.FAST_CAST,     power = -30,   textId = ID.text.AFFLICTION_CASTING_SPEED_DOWN }, -- Casting speed reduced
    [11] = { effect = xi.effect.DEBILITATION,  power = 0x001, textId = ID.text.AFFLICTION_STR_DOWN           }, -- STR
    [12] = { effect = xi.effect.DEBILITATION,  power = 0x002, textId = ID.text.AFFLICTION_DEX_DOWN           }, -- DEX
    [13] = { effect = xi.effect.DEBILITATION,  power = 0x004, textId = ID.text.AFFLICTION_VIT_DOWN           }, -- VIT
    [14] = { effect = xi.effect.DEBILITATION,  power = 0x008, textId = ID.text.AFFLICTION_AGI_DOWN           }, -- AGI
    [15] = { effect = xi.effect.DEBILITATION,  power = 0x010, textId = ID.text.AFFLICTION_INT_DOWN           }, -- INT
    [16] = { effect = xi.effect.DEBILITATION,  power = 0x020, textId = ID.text.AFFLICTION_MND_DOWN           }, -- MND
    [17] = { effect = xi.effect.DEBILITATION,  power = 0x040, textId = ID.text.AFFLICTION_CHR_DOWN           }, -- CHR
    -- Positive Effects.
    [18] = { effect = xi.effect.REGAIN,        power = 5,     textId = ID.text.RECEIVED_REGAIN_EFFECT        }, -- confirmed 50
    [19] = { effect = xi.effect.REGEN,         power = 15,    textId = ID.text.RECEIVED_REGEN_EFFECT         }, -- confirmed 15
    [20] = { effect = xi.effect.REFRESH,       power = 10,    textId = ID.text.RECEIVED_REFRESH_EFFECT       }, -- confirmed 10
    [21] = { effect = xi.effect.FLURRY,        power = 15,    textId = ID.text.RECEIVED_FLURRY_EFFECT        },
    [22] = { effect = xi.effect.CONCENTRATION, power = 30,    textId = ID.text.RECEIVED_CONCENTRATION_EFFECT },
    [23] = { effect = xi.effect.STR_BOOST_II,  power = 30,    textId = ID.text.RECEIVED_STR_BOOST            }, -- confirmed 30
    [24] = { effect = xi.effect.DEX_BOOST_II,  power = 30,    textId = ID.text.RECEIVED_DEX_BOOST            },
    [25] = { effect = xi.effect.VIT_BOOST_II,  power = 30,    textId = ID.text.RECEIVED_VIT_BOOST            },
    [26] = { effect = xi.effect.AGI_BOOST_II,  power = 30,    textId = ID.text.RECEIVED_AGI_BOOST            },
    [27] = { effect = xi.effect.INT_BOOST_II,  power = 30,    textId = ID.text.RECEIVED_INT_BOOST            },
    [28] = { effect = xi.effect.MND_BOOST_II,  power = 30,    textId = ID.text.RECEIVED_MND_BOOST            },
    [29] = { effect = xi.effect.CHR_BOOST_II,  power = 30,    textId = ID.text.RECEIVED_CHR_BOOST            },
}

-----------------------------------
-- Penalty selection local function.
-----------------------------------
local function addPenalty(mob)
    local instance = mob:getInstance()
    local pathos   = instance:getLocalVar("floorPathos")
    local penalty  = instance:getLocalVar("gearPenalty")
    local chars    = instance:getChars()

    -- Time penalty.
    if penalty == xi.nyzul.penalty.TIME then
        local timeLimit = instance:getTimeLimit() * 60

        instance:setTimeLimit(timeLimit - 60)

        for _, players in pairs(chars) do
            players:messageSpecial(ID.text.MALFUNCTION)
            players:messageSpecial(ID.text.TIME_LOSS, 1)
        end

    -- Token penalty.
    elseif penalty == xi.nyzul.penalty.TOKENS then
        local tokenPenalty = instance:getLocalVar("tokenPenalty")

        tokenPenalty = tokenPenalty + 1
        instance:setLocalVar("tokenPenalty", tokenPenalty)

        for _, players in pairs(chars) do
            players:messageSpecial(ID.text.MALFUNCTION)
            players:messageSpecial(ID.text.TOKEN_LOSS)
        end

    -- Status effect penalty.
    else
        -- Create table with negative pathos that are not currently set.
        local availablePathos = {}

        for i = 1, 17 do
            if not utils.mask.getBit(pathos, i) then
                table.insert(availablePathos, i)
            end
        end

        -- Pick a random pathos to apply from the available pathos table.
        if #availablePathos > 0 then -- Failsafe in case all 17 are applied. Unlikely, but just in case.
            local randomEffect = availablePathos[math.random(1, #availablePathos)]

            instance:setLocalVar("floorPathos", utils.mask.setBit(pathos, randomEffect, true))
            pathos = xi.nyzul.pathosList[randomEffect]

            local effect = pathos.effect
            local power  = pathos.power

            for _, player in pairs(chars) do
                if
                    effect == xi.effect.IMPAIRMENT or
                    effect == xi.effect.OMERTA or
                    effect == xi.effect.DEBILITATION
                then
                    if player:hasStatusEffect(effect) then
                        local statusEffect = player:getStatusEffect(effect)
                        local effectPower  = statusEffect:getPower()
                        power              = bit.bor(effectPower, power)
                    end
                end

                player:addStatusEffect(effect, power, 0, 0)
                player:getStatusEffect(effect):unsetFlag(xi.effectFlag.DISPELABLE)
                player:getStatusEffect(effect):unsetFlag(xi.effectFlag.ERASABLE)
                player:getStatusEffect(effect):setFlag(xi.effectFlag.ON_ZONE_PATHOS)
                player:messageSpecial(ID.text.MALFUNCTION)
                player:messageSpecial(pathos.textId)

                if player:hasPet() then
                    local pet = player:getPet()
                    pet:addStatusEffectEx(effect, effect, power, 0, 0)
                    pet:getStatusEffect(effect):unsetFlag(xi.effectFlag.DISPELABLE)
                    pet:getStatusEffect(effect):unsetFlag(xi.effectFlag.ERASABLE)
                    pet:getStatusEffect(effect):setFlag(xi.effectFlag.ON_ZONE_PATHOS)
                end
            end
        end
    end
end

-----------------------------------
-- Pathos cleanup and addition global functions.
-----------------------------------
xi.nyzul.removePathos = function(instance)
    if instance:getLocalVar("floorPathos") > 0 then
        for i = 1, #xi.nyzul.pathosList do
            if utils.mask.getBit(instance:getLocalVar("floorPathos"), i) then
                local removeMessage = xi.nyzul.pathosList[i].ID
                local chars         = instance:getChars()

                for _, players in pairs(chars) do
                    players:delStatusEffectSilent(xi.nyzul.pathosList[i].effect)
                    players:messageSpecial(removeMessage - 1)

                    if players:hasPet() then
                        local pet = players:getPet()
                        pet:delStatusEffectSilent(xi.nyzul.pathosList[i].effect)
                    end
                end

                instance:setLocalVar("floorPathos", utils.mask.setBit(instance:getLocalVar("floorPathos"), i, false))
            end
        end
    end
end

xi.nyzul.addFloorPathos = function(instance)
    local randomPathos = instance:getLocalVar("randomPathos")

    if randomPathos > 0 then
        instance:setLocalVar("floorPathos", utils.mask.setBit(instance:getLocalVar("floorPathos"), randomPathos, true))

        local pathos = xi.nyzul.pathosList[randomPathos]
        local chars  = instance:getChars()

        for _, player in pairs(chars) do
            player:addStatusEffect(pathos.effect, pathos.power, 0, 0)
            player:getStatusEffect(pathos.effect):unsetFlag(xi.effectFlag.DISPELABLE)
            player:getStatusEffect(pathos.effect):unsetFlag(xi.effectFlag.ERASABLE)
            player:getStatusEffect(pathos.effect):setFlag(xi.effectFlag.ON_ZONE_PATHOS)

            player:messageSpecial(pathos.textId)

            if player:hasPet() then
                local pet = player:getPet()
                pet:addStatusEffectEx(pathos.effect, pathos.effect, pathos.power, 0, 0)
                pet:getStatusEffect(pathos.effect):unsetFlag(xi.effectFlag.DISPELABLE)
                pet:getStatusEffect(pathos.effect):unsetFlag(xi.effectFlag.ERASABLE)
                pet:getStatusEffect(pathos.effect):setFlag(xi.effectFlag.ON_ZONE_PATHOS)
            end
        end

        instance:setLocalVar("randomPathos", 0)
    end
end

-----------------------------------
-- Gear type mobs global functions.
-----------------------------------
xi.nyzul.onGearEngage = function(mob, target)
    local instance = mob:getInstance()

    if instance:getLocalVar("gearObjective") == xi.nyzul.gearObjective.AVOID_AGRO then
        local ce = mob:getCE(target)
        local ve = mob:getVE(target)

        if
            ce == 0 and
            ve == 0 and
            mob:getLocalVar("initialAgro") == 0
        then
            mob:setLocalVar("initialAgro", 1)
            addPenalty(mob)
        end
    end
end

xi.nyzul.onGearDeath = function(mob)
    local instance = mob:getInstance()

    if instance:getLocalVar("gearObjective") == xi.nyzul.gearObjective.DO_NOT_DESTROY then
        addPenalty(mob)
    end
end
