-----------------------------------------
-- Spell: Esuna
--
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)

    if (caster:getID() == target:getID()) then -- much of this should only run once per cast, otherwise it would only delete the debuffs from the caster.

        local statusNum = -1
        local removables = {tpz.effect.FLASH, tpz.effect.BLINDNESS, tpz.effect.PARALYSIS, tpz.effect.POISON, tpz.effect.CURSE_I, tpz.effect.CURSE_II, tpz.effect.DISEASE, tpz.effect.PLAGUE}

        if (caster:hasStatusEffect(tpz.effect.AFFLATUS_MISERY)) then -- add extra statuses to the list of removables. Elegy and Requiem are specifically absent.
            removables = {tpz.effect.FLASH, tpz.effect.BLINDNESS, tpz.effect.PARALYSIS, tpz.effect.POISON, tpz.effect.CURSE_I, tpz.effect.CURSE_II, tpz.effect.DISEASE, tpz.effect.PLAGUE, tpz.effect.WEIGHT, tpz.effect.BIND, tpz.effect.BIO, tpz.effect.DIA, tpz.effect.BURN, tpz.effect.FROST, tpz.effect.CHOKE, tpz.effect.RASP, tpz.effect.SHOCK, tpz.effect.DROWN, tpz.effect.STR_DOWN, tpz.effect.DEX_DOWN, tpz.effect.VIT_DOWN, tpz.effect.AGI_DOWN, tpz.effect.INT_DOWN, tpz.effect.MND_DOWN, tpz.effect.CHR_DOWN, tpz.effect.ADDLE, tpz.effect.SLOW, tpz.effect.HELIX, tpz.effect.ACCURACY_DOWN, tpz.effect.ATTACK_DOWN, tpz.effect.EVASION_DOWN, tpz.effect.DEFENSE_DOWN, tpz.effect.MAGIC_ACC_DOWN, tpz.effect.MAGIC_ATK_DOWN, tpz.effect.MAGIC_EVASION_DOWN, tpz.effect.MAGIC_DEF_DOWN, tpz.effect.MAX_TP_DOWN, tpz.effect.MAX_MP_DOWN, tpz.effect.MAX_HP_DOWN}
        end

        local has = {}

        -- collect a list of what caster currently has
        for i, effect in ipairs(removables) do
            if (caster:hasStatusEffect(effect)) then
                statusNum = statusNum + 1
                has[statusNum] = removables[i]
            end
        end

        if (statusNum >= 0) then -- make sure this happens once instead of for every target
            local delEff = math.random(0, statusNum) -- pick a random status to delete
            caster:setLocalVar("esunaDelEff", has[delEff]) -- this can't be a local because it would only delete from the caster if it were.
        else -- clear it if the caster has no eligible statuses, otherwise it will remove the status from others if it was previously removed.
            caster:setLocalVar("esunaDelEff", 0)
            caster:setLocalVar("esunaDelEffMis", 0)  -- again, this can't be a local because it would only delete from the caster if it were. For extra status deletion under Misery
        end

        if (statusNum >= 1 and caster:hasStatusEffect(tpz.effect.AFFLATUS_MISERY)) then -- Misery second status removal.
            caster:delStatusEffect(has[delEff]) -- delete the first selected effect so it doesn't get selected again. Won't impact the ability to delete it from others at this point.
            local statusNumMis =  - 1 -- need a new var to track the amount of debuffs for the array

            -- collect a list of what caster currently has, again.
            has = {}
            for i, effect in ipairs(removables) do
                if (caster:hasStatusEffect(effect)) then
                    statusNumMis = statusNumMis + 1
                    has[statusNumMis] = removables[i]
                end
            end

            local delEffMis = math.random(0, statusNumMis) -- pick another random status to delete
            caster:setLocalVar("esunaDelEffMis", has[delEffMis])
        else
            caster:setLocalVar("esunaDelEffMis", 0)
        end
    end

    local statusDel = caster:getLocalVar("esunaDelEff")
    local statusDelMis = caster:getLocalVar("esunaDelEffMis")

    if (statusDel == 0) then -- this gets set to 0 if there's no status to delete.
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT) -- no effect
    elseif (statusDelMis ~= 0) then -- no need to check for statusDelMis because it can't be 0 if this isn't
        target:delStatusEffect(statusDel)
        target:delStatusEffect(statusDelMis)
    else
        target:delStatusEffect(statusDel)
    end

    return statusDel
end
