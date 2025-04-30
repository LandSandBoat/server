-----------------------------------
-- Area: Nyzul Isle (Waking the Colossus / Divine Interference)
--  Mob: Alexander
-----------------------------------
local ID = zones[xi.zone.NYZUL_ISLE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:addListener('WEAPONSKILL_STATE_ENTER', 'WS_START_MSG', function(mobArg, skillID)
        local skillMessage =
        {
            [xi.mobSkill.RADIANT_SACRAMENT]  = { ID.text.OFFER_THY_WORSHIP },
            [xi.mobSkill.MEGA_HOLY]          = { ID.text.OPEN_THINE_EYES },
            [xi.mobSkill.PERFECT_DEFENSE]    = { ID.text.CEASE_THY_STRUGGLES },
            [xi.mobSkill.DIVINE_SPEAR]       = { ID.text.RELEASE_THY_SELF },
            [xi.mobSkill.GOSPEL_OF_THE_LOST] = { ID.text.BASK_IN_MY_GLORY },
            [xi.mobSkill.VOID_OF_REPENTANCE] = { ID.text.REPENT_THY_IRREVERENCE },
            [xi.mobSkill.DIVINE_JUDGMENT]    = { ID.text.ACCEPT_THY_DESTRUCTION, ID.text.OMEGA_SPAM },
        }

        if skillMessage[skillID] then
            for _, message in ipairs(skillMessage[skillID]) do
                mobArg:showText(mobArg, message)
            end
        end

        if skillID == xi.mobSkill.VOID_OF_REPENTANCE then
            -- Spawn first available Alexander_Image
            for _, mobId in ipairs(ID.mob.ALEXANDER_IMAGE) do
                local image = GetMobByID(mobId, mob:getInstance())
                if image and not image:isSpawned() then
                    image:setSpawn(mob:getXPos() + math.random(-2, 2), mob:getYPos() + math.random(-2, 2), mob:getZPos() + math.random(-2, 2), mob:getRotPos())
                    image:spawn()

                    local target = mob:getTarget()
                    if target then
                        image:updateEnmity(target)
                    end

                    return
                end
            end
        end
    end)
end

entity.onMobEngage = function(mob, target)
    mob:showText(mob, ID.text.SHALL_BE_JUDGED)
end

entity.onMobFight = function(mob, target)
    -- BG Wiki: 'He will use this ability at 50% of his HP and several times again as his health decreases.'
    -- ffxiclopedia: 'Alexander will use this ability as his next TP move once its HP falls below 50%.'
    if
        mob:getHPP() <= 50 and
        mob:getTP() >= 1000 and
        mob:getLocalVar('DivineJudgement') == 0
    then
        mob:setLocalVar('DivineJudgement', 1)
        mob:useMobAbility(xi.mobSkill.DIVINE_JUDGMENT)
    end

    -- ffxiclopedia: 'In addition to this, it's possible he'll use it several times again at low (5%?) HP.'
    -- Per same wiki, may use Perfect Defense as a regular skill at 10%..Assuming same % for both skills.
    local skillList = mob:getMobMod(xi.mobMod.SKILL_LIST)
    if mob:getHPP() <= 10 and skillList == 784 then
        mob:setMobMod(xi.mobMod.SKILL_LIST, 785) -- Alexander_LowHP
    end

    local drawInTable =
    {
        conditions =
        {
            mob:checkDistance(target) > 20,
        },
        position = mob:getPos(),
    }
    utils.drawIn(target, drawInTable)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        mob:showText(mob, ID.text.SHALL_KNOW_OBLIVION)
    end
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    instance:setProgress(instance:getProgress() + 1)
end

return entity
