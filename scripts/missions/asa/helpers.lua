-----------------------------------
-- A Shantotto Ascension Helpers
-----------------------------------
xi = xi or {}
xi.asa = xi.asa or {}
xi.asa.helpers = xi.asa.helpers or {}

-- Saps for Fountain of Trouble (ASA-9) and Battaru Royale (ASA-10).
xi.asa.helpers.sapCrystals =
{
    xi.keyItem.FIRE_SAP_CRYSTAL,
    xi.keyItem.WATER_SAP_CRYSTAL,
    xi.keyItem.WIND_SAP_CRYSTAL,
    xi.keyItem.EARTH_SAP_CRYSTAL,
    xi.keyItem.LIGHTNING_SAP_CRYSTAL,
    xi.keyItem.ICE_SAP_CRYSTAL,
    xi.keyItem.LIGHT_SAP_CRYSTAL,
    xi.keyItem.DARK_SAP_CRYSTAL,
}

xi.asa.helpers.countKeyItems = function(player, keyItems)
    local count = 0
    for _, keyItem in ipairs(keyItems) do
        if player:hasKeyItem(keyItem) then
            count = count + 1
        end
    end

    return count
end

xi.asa.helpers.delKeyItems = function(player, keyItems)
    for _, keyItem in ipairs(keyItems) do
        player:delKeyItem(keyItem)
    end
end

-----------------------------------
-- ASA-4: Sugar-Coated Directive
-----------------------------------

-- A local var, so the protocrystal refuses the seal again after every zone in, as observed on retail.
xi.asa.helpers.sugarCoatedStymiedVar = '[ASA]Stymied'

-- winVar outlives the zone, since the player may leave before attaching the seal.
xi.asa.helpers.sugarCoated =
{
    [xi.zone.CLOISTER_OF_FLAMES] =
    {
        seal        = xi.keyItem.DOMINAS_SCARLET_SEAL,
        counterseal = xi.keyItem.SCARLET_COUNTERSEAL,
        winVar      = '[ASA]IfritWin',
        astralFlows = { xi.mobSkill.INFERNO_1, xi.mobSkill.INFERNO_4 },
    },

    [xi.zone.CLOISTER_OF_FROST] =
    {
        seal        = xi.keyItem.DOMINAS_AZURE_SEAL,
        counterseal = xi.keyItem.AZURE_COUNTERSEAL,
        winVar      = '[ASA]ShivaWin',
        astralFlows = { xi.mobSkill.DIAMOND_DUST_1, xi.mobSkill.DIAMOND_DUST_4 },
    },

    [xi.zone.CLOISTER_OF_GALES] =
    {
        seal        = xi.keyItem.DOMINAS_EMERALD_SEAL,
        counterseal = xi.keyItem.EMERALD_COUNTERSEAL,
        winVar      = '[ASA]GarudaWin',
        astralFlows = { xi.mobSkill.AERIAL_BLAST_1, xi.mobSkill.AERIAL_BLAST_4 },
    },

    [xi.zone.CLOISTER_OF_STORMS] =
    {
        seal        = xi.keyItem.DOMINAS_VIOLET_SEAL,
        counterseal = xi.keyItem.VIOLET_COUNTERSEAL,
        winVar      = '[ASA]RamuhWin',
        astralFlows = { xi.mobSkill.JUDGMENT_BOLT_1, xi.mobSkill.JUDGMENT_BOLT_4 },
    },

    [xi.zone.CLOISTER_OF_TIDES] =
    {
        seal        = xi.keyItem.DOMINAS_CERULEAN_SEAL,
        counterseal = xi.keyItem.CERULEAN_COUNTERSEAL,
        winVar      = '[ASA]LeviathanWin',
        astralFlows = { xi.mobSkill.TIDAL_WAVE_1, xi.mobSkill.TIDAL_WAVE_4 },
    },

    [xi.zone.CLOISTER_OF_TREMORS] =
    {
        seal        = xi.keyItem.DOMINAS_AMBER_SEAL,
        counterseal = xi.keyItem.AMBER_COUNTERSEAL,
        winVar      = '[ASA]TitanWin',
        astralFlows = { xi.mobSkill.EARTHEN_FURY_1, xi.mobSkill.EARTHEN_FURY_4 },
    },
}

-- Entry stays open after the mission for the Bird key repeat. TODO: Squintrox Dryeyes hands out the seals for it.
xi.asa.helpers.sugarCoatedEntry = function(player)
    local current = player:getCurrentMission(xi.mission.log_id.ASA)

    if
        current ~= xi.mission.id.asa.SUGAR_COATED_DIRECTIVE and
        not player:hasCompletedMission(xi.mission.log_id.ASA, xi.mission.id.asa.SUGAR_COATED_DIRECTIVE)
    then
        return false
    end

    return player:getLocalVar(xi.asa.helpers.sugarCoatedStymiedVar) == 1
end

-- Observed on retail: flows at 80, 60, 40, 20 and 1 percent.
local astralFlowThresholds = { 80, 60, 40, 20, 1 }

-- Observed on retail: the avatar takes about 30 percent damage while pinned at 1 percent.
local floorDamageTakenP = -7000

-- The fifth flow uses the longer skill, and only after it does the avatar become killable.
xi.asa.helpers.astralFlow = function(mob)
    local flow       = mob:getLocalVar('astralflows')
    local floorStage = mob:getLocalVar('astralFloor')

    if mob:getHPP() <= 1 and floorStage == 0 then
        floorStage = 1
        mob:setLocalVar('astralFloor', floorStage)
        mob:addMod(xi.mod.DMG, floorDamageTakenP)
    end

    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    if flow > #astralFlowThresholds then
        if floorStage == 1 then
            mob:setLocalVar('astralFloor', 2)
            mob:delMod(xi.mod.DMG, floorDamageTakenP)
            mob:setUnkillable(false)
        end

        return
    end

    local currentTime = GetSystemTime()
    if
        mob:getHPP() <= astralFlowThresholds[flow] and
        currentTime >= mob:getLocalVar('astralFlowReady')
    then
        local skills = xi.asa.helpers.sugarCoated[mob:getZoneID()].astralFlows
        local skill  = skills[1]
        if flow == #astralFlowThresholds then
            skill = skills[2]
        end

        -- Observed on retail: the flows come at least eight seconds apart.
        mob:setLocalVar('astralflows', flow + 1)
        mob:setLocalVar('astralFlowReady', currentTime + 8)
        mob:useMobAbility(skill)
    end
end

-----------------------------------
-- ASA-6: Enemy of the Empire II, the Tenshodo agents in Gustav Tunnel
-----------------------------------
local gustavID = zones[xi.zone.GUSTAV_TUNNEL]
local agentIds = { gustavID.mob.RENFRED, gustavID.mob.GORATTZ, gustavID.mob.BOMPUPU }

-- Observed on retail, except the wipe grace and the level cap, which is not below 99.
local agentFight =
{
    timeLimit       = utils.minutes(30),
    warningAt       = utils.minutes(20),
    wipeGrace       = utils.minutes(3),
    cloneCount      = 3,
    activationDowns = 8,
    cloneVanish     = 3,
    cloneReturn     = 6,
    agentVanish     = 5,
    utsusemiAt      = { 3, 9, 15 },
    maxFighters     = 18,
    expReward       = 500,
}

xi.asa.helpers.isAgentFightActive = function()
    local npc = GetNPCByID(gustavID.npc.OUTCROPPING)
    if not npc then
        return false
    end

    if xi.confrontation.lookup[xi.confrontation.getKey(npc)] then
        return true
    end

    for _, agentId in ipairs(agentIds) do
        local agent = GetMobByID(agentId)
        if agent and agent:isSpawned() then
            return true
        end
    end

    return false
end

local function despawnAgentClones()
    for _, agentId in ipairs(agentIds) do
        for slot = 1, agentFight.cloneCount do
            DespawnMob(agentId + slot)
        end
    end
end

xi.asa.helpers.startAgentFight = function(player, npc)
    npc:setLocalVar('agentFightOwner', player:getID())
    npc:setLocalVar('agentCloneDowns', 0)

    player:messageSpecial(gustavID.text.TIME_TO_COMPLETE_BATTLE, agentFight.timeLimit / 60)
    player:delKeyItem(xi.keyItem.BLACK_BOOK)
    player:messageSpecial(gustavID.text.KEYITEM_LOST, xi.keyItem.BLACK_BOOK)

    local fighters   = {}
    local fighterIds = {}
    for _, member in ipairs(player:getAlliance()) do
        if
            member:getZoneID() == xi.zone.GUSTAV_TUNNEL and
            #fighters < agentFight.maxFighters
        then
            table.insert(fighters, member)
            table.insert(fighterIds, member:getID())
            member:addStatusEffect(xi.effect.LEVEL_RESTRICTION, { power = 99, origin = member, duration = agentFight.timeLimit })
        end
    end

    for _, agentId in ipairs(agentIds) do
        SpawnMob(agentId)
    end

    xi.confrontation.start(player, npc, agentIds,
    {
        playerList  = fighters,
        skipSpawn   = true,
        timeLimit   = agentFight.timeLimit,
        warnAt      = agentFight.warningAt,
        wipeGrace   = agentFight.wipeGrace,
        retagRaised = true,

        onWarn = function(member)
            member:messageSpecial(gustavID.text.TIME_REMAINING_BATTLE, (agentFight.timeLimit - agentFight.warningAt) / 60)
        end,

        -- Observed on retail: the clones vanish at once on a wipe. TODO: Capture needed, a raise inside the grace brings them back.
        onWipe = despawnAgentClones,

        onRecover = function()
            local currentTime = GetSystemTime()
            for _, agentId in ipairs(agentIds) do
                local agent = GetMobByID(agentId)
                for slot = 1, agentFight.cloneCount do
                    local clone = GetMobByID(agentId + slot)
                    if agent and agent:isAlive() and clone and not clone:isSpawned() then
                        agent:setLocalVar(string.format('cloneSpawnAt%d', slot), currentTime + math.randomInt(10, 18))
                    end
                end
            end
        end,

        onWin = function(member)
            if member:getZoneID() ~= xi.zone.GUSTAV_TUNNEL or not member:isAlive() then
                return
            end

            member:addExp(agentFight.expReward)

            if member:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_II then
                xi.mission.setVar(member, xi.mission.log_id.ASA, xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_II, 'Won', 1)
            end

            npcUtil.giveKeyItem(member, xi.keyItem.CACTUAR_KEY)
        end,

        onLose = function(member)
            if member:getZoneID() == xi.zone.GUSTAV_TUNNEL then
                member:messageText(member, gustavID.text.OPPONENTS_DISAPPEAR)
            end
        end,

        cleanUp = function()
            despawnAgentClones()

            for _, fighterId in ipairs(fighterIds) do
                local member = GetPlayerByID(fighterId)
                if member then
                    member:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
                end
            end

            npc:setLocalVar('agentFightOwner', 0)
        end,
    })
end

-- An untargetable caster is refused by the spell system, so the shadows go on directly until activation.
local function castUtsusemi(agent)
    if agent:getUntargetable() then
        agent:addStatusEffect(xi.effect.COPY_IMAGE, { power = 4, subPower = xi.effect.COPY_IMAGE_4, origin = agent })
        return
    end

    agent:castSpell(xi.magic.spell.UTSUSEMI_NI, agent)
end

xi.asa.helpers.onAgentSpawn = function(mob)
    local npc = GetNPCByID(gustavID.npc.OUTCROPPING)
    mob:addStatusEffect(xi.effect.CONFRONTATION, { power = xi.confrontation.getKey(npc), origin = mob })

    -- Clones sit at the three ids after their agent.
    for _, agentId in ipairs(agentIds) do
        local slot = mob:getID() - agentId
        if slot >= 1 and slot <= agentFight.cloneCount then
            mob:setLocalVar('cloneSlot', slot)
            mob:setUnkillable(true)
            return
        end
    end

    local currentTime = GetSystemTime()

    mob:setUntargetable(true)
    mob:setAggressive(false)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setLocalVar('utsusemiStage', 1)
    mob:setLocalVar('spawnedAt', currentTime)

    for slot = 1, agentFight.cloneCount do
        mob:setLocalVar(string.format('cloneSpawnAt%d', slot), currentTime + math.randomInt(10, 18))
    end

    if mob:getID() == gustavID.mob.RENFRED then
        mob:setLocalVar('tauntAt', currentTime + 2)
    end
end

-- A clone pinned at 1 percent vanishes and its agent shadows itself again to bring it back.
xi.asa.helpers.onAgentCloneTick = function(mob)
    local slot = mob:getLocalVar('cloneSlot')
    if slot == 0 or xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local npc   = GetNPCByID(gustavID.npc.OUTCROPPING)
    local agent = GetMobByID(mob:getID() - slot)
    if not npc or not agent then
        return
    end

    local currentTime = GetSystemTime()
    local vanishAt    = mob:getLocalVar('vanishAt')
    if vanishAt == 0 then
        if not agent:isAlive() then
            mob:setLocalVar('vanishAt', currentTime + agentFight.agentVanish)
        elseif mob:getHPP() <= 1 then
            mob:setLocalVar('vanishAt', currentTime + agentFight.cloneVanish)
        end

        return
    end

    if currentTime < vanishAt then
        return
    end

    mob:messageName(gustavID.text.SHADOW_IMAGE_DISAPPEARS, mob)
    DespawnMob(mob:getID())

    if not agent:isAlive() then
        return
    end

    agent:setLocalVar('recastAt', currentTime + 2)
    agent:setLocalVar(string.format('cloneSpawnAt%d', slot), currentTime + agentFight.cloneReturn)

    -- The eighth shadow down brings the agents into the fight.
    local downs = npc:getLocalVar('agentCloneDowns') + 1
    npc:setLocalVar('agentCloneDowns', downs)
    if downs ~= agentFight.activationDowns then
        return
    end

    local owner = GetPlayerByID(npc:getLocalVar('agentFightOwner'))
    for _, agentId in ipairs(agentIds) do
        local other = GetMobByID(agentId)
        if other and other:isSpawned() and other:isAlive() then
            other:setUntargetable(false)
            other:setAggressive(true)
            other:setMobMod(xi.mobMod.NO_MOVE, 0)

            if owner and owner:getZoneID() == xi.zone.GUSTAV_TUNNEL then
                other:updateEnmity(owner)
            end
        end
    end

    local renfred = GetMobByID(gustavID.mob.RENFRED)
    if renfred and renfred:isSpawned() and renfred:isAlive() then
        renfred:messageText(renfred, gustavID.text.RENFRED_PUTTING_UP_A_FIGHT)
    end
end

xi.asa.helpers.onAgentTick = function(mob)
    if mob:getLocalVar('cloneSlot') ~= 0 or xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local npc = GetNPCByID(gustavID.npc.OUTCROPPING)
    if not npc or npc:getLocalVar('agentFightOwner') == 0 then
        return
    end

    local currentTime = GetSystemTime()
    local tauntAt     = mob:getLocalVar('tauntAt')
    if tauntAt ~= 0 and currentTime >= tauntAt then
        mob:setLocalVar('tauntAt', 0)
        mob:messageText(mob, gustavID.text.RENFRED_NOT_INTERESTED)
    end

    local stage = mob:getLocalVar('utsusemiStage')
    if
        stage <= #agentFight.utsusemiAt and
        currentTime >= mob:getLocalVar('spawnedAt') + agentFight.utsusemiAt[stage]
    then
        mob:setLocalVar('utsusemiStage', stage + 1)
        castUtsusemi(mob)
    end

    local recastAt = mob:getLocalVar('recastAt')
    if recastAt ~= 0 and currentTime >= recastAt then
        mob:setLocalVar('recastAt', 0)
        castUtsusemi(mob)
    end

    for cloneSlot = 1, agentFight.cloneCount do
        local var     = string.format('cloneSpawnAt%d', cloneSlot)
        local spawnAt = mob:getLocalVar(var)
        local clone   = GetMobByID(mob:getID() + cloneSlot)
        if
            spawnAt ~= 0 and
            currentTime >= spawnAt and
            clone and
            not clone:isSpawned()
        then
            mob:setLocalVar(var, 0)
            clone:setSpawn(mob:getXPos() + math.randomFloat(-1.5, 1.5), mob:getYPos(), mob:getZPos() + math.randomFloat(-1.5, 1.5), mob:getRotPos())
            SpawnMob(clone:getID())

            local owner = GetPlayerByID(npc:getLocalVar('agentFightOwner'))
            if owner and owner:getZoneID() == xi.zone.GUSTAV_TUNNEL then
                clone:updateEnmity(owner)
            end
        end
    end
end

-----------------------------------
-- ASA-8: luminous fragment mobs
-----------------------------------
-- Remember what landed the killing blow so the fragment can be gated on it.
xi.asa.helpers.trackKillingBlow = function(mob)
    mob:addListener('TAKE_DAMAGE', 'ASA_KILLING_BLOW', function(mobArg, damage, attacker, attackType, damageType)
        mobArg:setLocalVar('asaAttackType', attackType)
        mobArg:setLocalVar('asaDamageType', damageType)
    end)
end

-----------------------------------
-- ASA-10: Battaru Royale clones
-----------------------------------

-- Observed on retail: about 1 percent every 19 seconds.
xi.asa.helpers.onCloneSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ASTRAL_PET_OFFSET, 1)
    mob:setMod(xi.mod.REGEN, 10)
end

-- Observed on retail: each clone summons its avatar once, the first time it is below 75 percent and free to act.
xi.asa.helpers.onCloneFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    if
        mob:getLocalVar('astralFlowUsed') == 0 and
        mob:getHPP() < 75
    then
        mob:setLocalVar('astralFlowUsed', 1)
        mob:useMobAbility(xi.mobSkill.ASTRAL_FLOW_1)
    end
end
