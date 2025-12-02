-----------------------------------
-- Area: Mine Shaft 2716
-- CoP Mission 5-3 (A Century of Hardship)
-- NM: CheckoChuk
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
local ID = zones[xi.zone.MINE_SHAFT_2716]
-----------------------------------
---@type TMobEntity
local entity = {}

local mobDialogue =
{
    [ID.mob.MOVAMUQ  ] = { base = ID.text.MOVAMUQ_DIALOGUE,   offset = 7 },
    [ID.mob.TRIKOTRAK] = { base = ID.text.TRIKOTRAK_DIALOGUE, offset = 7 },
    [ID.mob.SWIPOSTIK] = { base = ID.text.SWIPOSTIK_DIALOGUE, offset = 6 },
    [ID.mob.BUGBBY   ] = { base = ID.text.BUGBBY_DIALOGUE,    offset = 10 },
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMobAbilityEnabled(false)

    -- Add listener for dice reset reactions from other Moblins
    mob:addListener('WEAPONSKILL_STATE_EXIT', 'CHEKOCHUK_DICE_RESET', function(mobArg, skillId)
        if skillId ~= xi.mobSkill.GOBLIN_DICE_RESET then
            return
        end

        local battlefield = mobArg:getBattlefield()
        if not battlefield then
            return
        end

        local area = battlefield:getArea()
        local offset = (area - 1) * 5

        -- Show reactions for all other battlefield mobs
        for baseMobID, dialogue in pairs(mobDialogue) do
            local reactionMob = GetMobByID(baseMobID + offset)
            if reactionMob and reactionMob:isAlive() then
                reactionMob:showText(reactionMob, dialogue.base + dialogue.offset)
            end
        end
    end)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    local hpTripper = mob:getLocalVar('hpTripper')
    if
        (mob:getHPP() <= 50 and hpTripper == 0) or
        (mob:getHPP() <= 25 and hpTripper == 1)
    then
        mob:setLocalVar('hpTripper', hpTripper + 1)
        battlefield:setLocalVar('triggerMoblinCommand', mob:getID())
    end
end

entity.onMobMobskillChoose = function(mob, target)
    return xi.mobSkill.GOBLIN_DICE_HEAL + math.random(0, 10)
end

entity.onMobDespawn = function(mob)
    mob:removeListener('CHEKOCHUK_DICE_RESET')
end

return entity
