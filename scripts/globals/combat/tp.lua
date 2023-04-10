require("scripts/globals/status")
require("scripts/globals/utils")
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.tp = xi.combat.tp or {}
-----------------------------------

-- returns a single melee hit's TP return
xi.combat.tp.getSingleMeleeHitTPReturn = function(actor, target, isZanshin)
    isZanshin = isZanshin or false -- optional input, defaults to false.

    local delay        = actor:getBaseDelay()
    local attackOutput = xi.combat.tp.getModifiedDelayAndCanZanshin(actor, delay)
    local tpReturn     = xi.combat.tp.calculateTPReturn(actor, attackOutput.modifiedDelay)

    if isZanshin and attackOutput.canZanshin then
        tpReturn = tpReturn + actor:getMerit(xi.merit.IKISHOTEN) -- https://www.bg-wiki.com/ffxi/Ikishoten
    end

    local storeTPModifier = (100 + actor:getMod(xi.mod.STORETP)) / 100

    return math.floor(tpReturn * storeTPModifier)
end

xi.combat.tp.getModifiedDelayAndCanZanshin = function(actor, delay)
    local modifiedDelay = delay
    local canZanshin    = false

    -- DW/H2H delay is halved for the purposes of a single hit's TP return when applicable, see https://www.bg-wiki.com/ffxi/Tactical_Points
    if actor:isDualWielding() then -- NOTE: this "isDualWielding" may trip on non-PCs even if they are "using h2h". If this is rectified in core in the future this should fall through correctly.
        modifiedDelay = (delay * (100 - actor:getMod(xi.mod.DUAL_WIELD)) / 100) / 2
    elseif actor:isUsingH2H() then
        if actor:getObjType() == xi.objType.PC then            -- handle h2h with > 1 swing only on PC
            if
                actor:getEquippedItem(xi.slot.SUB) ~= nil or   -- equipped shield = one swing
                actor:getSkillRank(xi.skill.HAND_TO_HAND) == 0 -- zero h2h rank skill = one swing
            then
                modifiedDelay = math.max((delay - actor:getMod(xi.mod.MARTIAL_ARTS)), 96) -- min delay of 96 total, https://www.bg-wiki.com/ffxi/Attack_Speed
                canZanshin    = true -- Zanshin can proc on an "unarmed" swing               -- https://www.bg-wiki.com/ffxi/Zanshin
            else
                modifiedDelay = math.max((delay - actor:getMod(xi.mod.MARTIAL_ARTS)) / 2, 48) -- min delay of 96 total so 96/2 per fist, https://www.bg-wiki.com/ffxi/Attack_Speed
            end
        else
            -- TODO: handle the corner case where a PC-like entity is using h2h but is only hitting with one "fist". Perhaps they have a shield with no main weapon.
            -- elseif actor:getAutoAttackHits() > 1
            modifiedDelay = math.max((delay - actor:getMod(xi.mod.MARTIAL_ARTS)) / 2, 48)
        end
    else -- single melee swing, either 1H or 2H
        canZanshin = true -- https://www.bg-wiki.com/ffxi/Zanshin
    end

    modifiedDelay = modifiedDelay * math.max((100 + actor:getMod(xi.mod.DELAYP)) / 100, 0.85) -- minimum cap of -15% https://www.bg-wiki.com/ffxi/Attack_Speed. Undocumented if 15% + Claymore Grip goes above 15%.

    return ({ canZanshin = canZanshin , modifiedDelay = math.floor(modifiedDelay) })
end

-- returns a single melee hit's TP return
xi.combat.tp.getSingleRangedHitTPReturn = function(actor, target)
    local delay = actor:getBaseRangedDelay() -- there do not appear to be any delay modifiers for ranged attacks, snapshot does not seem to effect this

    if delay > 0 then
        local storeTPModifier = (100 + actor:getMod(xi.mod.STORETP)) / 100

        return math.floor(xi.combat.tp.calculateTPReturn(actor, delay) * storeTPModifier)
    end

    return 0
end

-- https://www.bg-wiki.com/ffxi/Tactical_Points
-- Gainee is the target who is going to gain the TP.
-- For instance, if a player attacks a mob, the mob uses the mob formula when gaining TP from the returned hit.
-- This appears to be a measure to not buff mobs when players were buffed with the new TP gain formula.
xi.combat.tp.calculateTPReturn = function(gainee, delay)
    if gainee and gainee:getObjType() ~= xi.objType.MOB then -- Pets and PCs have been observed to use this formula
        if delay <= 180 then
            return math.floor(61 + ((delay - 180) * 63 / 360))
        elseif delay >= 181 and delay <= 540 then
            return math.floor(61 + ((delay - 180) * 88 / 360))
        elseif delay >= 541 and delay <= 630 then
            return math.floor(149 + ((delay - 540) * 20 / 360))
        elseif delay >= 631 and delay <= 720 then
            return math.floor(154 + ((delay - 630) * 28 / 360))
        elseif delay >= 721 and delay <= 900 then
            return math.floor(161 + ((delay - 720) * 24 / 360))
        else
            return math.floor(173 + ((delay - 900) * 28 / 360))
        end
    else -- mobs have been observed to use this formula -- http://wiki.ffo.jp/html/308.html
        if delay <= 180 then
            return math.floor(50 + ((delay - 180) * 15 / 180))
        elseif delay >= 181 and delay <= 450 then
            return math.floor(50 + ((delay - 180) * 65 / 270))
        elseif delay >= 451 and delay <= 480 then
            return math.floor(115 + ((delay - 450) * 15 / 30))
        elseif delay >= 481 and delay <= 530 then
            return math.floor(130 + ((delay - 480) * 15 / 30))
        elseif delay >= 53 and delay <= 900 then
            return math.floor(145 + ((delay - 530) * 35 / 470))
        end
    end
end

-- TODO: does Ikishoten factor into this as a bonus to baseTPGain if it procs on the hit? Needs verification.
xi.combat.tp.calculateTPGainOnPhysicalDamage = function(totalDamage, delay, actor, target)
    -- TODO: does dAGI penalty work against/for Trusts/Pets? Nothing is documented for this. Currently assuming mob only.
    if totalDamage > 0 and target and actor then
        local attackOutput       = xi.combat.tp.getModifiedDelayAndCanZanshin(actor, delay)
        local baseTPGain         = xi.combat.tp.calculateTPReturn(target, attackOutput.modifiedDelay)
        local dAGI               = actor:getMod(xi.mod.AGI) - target:getMod(xi.mod.AGI)
        local inhibitTPModifier  = (100 - target:getMod(xi.mod.INHIBIT_TP)) / 100         -- no known cap: https://www.bg-wiki.com/ffxi/Monster_TP_gain#Inhibit_TP
        local dAGIModifier       = utils.clamp(200 - (dAGI + 30) / 200, 1.0, 0.5)           -- 50% reduction at +70 dAGI: https://www.bg-wiki.com/ffxi/Monster_TP_gain
        local subtleBlowI        = math.min(actor:getMod(xi.mod.SUBTLE_BLOW), 50)        -- cap of 50% https://www.bg-wiki.com/ffxi/Subtle_Blow
        local subtleBlowII       = actor:getMod(xi.mod.SUBTLE_BLOW_II)                   -- no known cap
        local subtleBlowModifier = math.max((100 - subtleBlowI + subtleBlowII) / 100, 0.25) -- combined cap of 75% reduction: https://www.bg-wiki.com/ffxi/Subtle_Blow
        local storeTPModifier    = (100 + target:getMod(xi.mod.STORETP)) / 100

        -- TODO: unknown where/how many floor steps there are. Napkin math seems to be a single floor step, but given x/256 it's hard to tell
        -- TODO: unknown if player pets (automaton/wyvern/avatars) are affected by dAGI

        -- mob vs mob (via charm) is observed to use the (base * 1/3) formula instead of (base + 30)
        -- (base + 30) formula appears to be intentional by SE to make mobs "more dangerous" when hit by players/pets
        if
            target:getObjType() == xi.objType.MOB and
            actor:getObjType() ~= xi.objType.MOB
        then
            -- +30 sourced from http://wiki.ffo.jp/html/2621.html and tested in game
            return math.floor((baseTPGain + 30) * inhibitTPModifier * dAGIModifier * subtleBlowModifier * storeTPModifier)
        else
            -- 1/3rd sourced from https://www.bg-wiki.com/ffxi/Tactical_Points and tested in game
            return math.floor(baseTPGain * inhibitTPModifier * subtleBlowModifier * storeTPModifier * (1 / 3))
        end
    end

    return 0
end

xi.combat.tp.calculateTPGainOnMagicalDamage = function(totalDamage, actor, target)
    -- TODO: does dAGI penalty work against/for Trusts/Pets? Nothing is documented for this. Currently assuming mob only.
    if totalDamage > 0 and target and actor then
        local dAGI               = actor:getMod(xi.mod.AGI) - target:getMod(xi.mod.AGI)
        local inhibitTPModifier  = (100 - target:getMod(xi.mod.INHIBIT_TP)) / 100         -- no known cap: https://www.bg-wiki.com/ffxi/Monster_TP_gain#Inhibit_TP
        local dAGIModifier       = utils.clamp(200 - (dAGI + 30) / 200, 1.0, 0.5)           -- 50% reduction at +70 dAGI: https://www.bg-wiki.com/ffxi/Monster_TP_gain
        local subtleBlowI        = math.min(actor:getMod(xi.mod.SUBTLE_BLOW), 50)        -- cap of 50% https://www.bg-wiki.com/ffxi/Subtle_Blow
        local subtleBlowII       = actor:getMod(xi.mod.SUBTLE_BLOW_II)                   -- no known cap
        local subtleBlowModifier = math.max((100 - subtleBlowI + subtleBlowII) / 100, 0.25) -- combined cap of 75% reduction: https://www.bg-wiki.com/ffxi/Subtle_Blow
        local storeTPModifier    = (100 + target:getMod(xi.mod.STORETP)) / 100

        -- Similar caveats to above for physical damage, unknown where/how many floors but seems to be one.
        if target:getObjType() == xi.objType.MOB then
            return math.floor(100 * inhibitTPModifier * dAGIModifier * subtleBlowModifier * storeTPModifier) -- 100 sourced from testing & https://www.bg-wiki.com/ffxi/Monster_TP_gain#TP_gained_from_Magical_Damage
        else
            return math.floor(50 * inhibitTPModifier * subtleBlowModifier * storeTPModifier)                 -- 50 sourced from testing & https://www.bg-wiki.com/ffxi/Tactical_Points#Getting_hit_for_more_than_0_damage
        end
    end

    return 0
end
