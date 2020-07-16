---------------------------------------------------------
-- Trust
---------------------------------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/msg")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------------------

tpz = tpz or {}
tpz.trust = tpz.trust or {}

tpz.trust.message_offset =
{
    SPAWN          = 1,
    TEAMWORK_1     = 4,
    TEAMWORK_2     = 5,
    TEAMWORK_3     = 6,
    TEAMWORK_4     = 7,
    TEAMWORK_5     = 8,
    DEATH          = 9,
    DESPAWN        = 11,
    SPECIAL_MOVE_1 = 18,
}

tpz.trust.canCast = function(caster, spell, not_allowed_trust_ids)
    -- Trusts not allowed in an alliance
    if caster:checkSoloPartyAlliance() == 2 then
        return tpz.msg.basic.TRUST_NO_CAST_TRUST
    end

    -- Trusts only allowed in certain zones (Remove this for trusts everywhere)
    if not caster:canUseMisc(tpz.zoneMisc.TRUST) then
        -- TODO: Update area flags
        --return tpz.msg.basic.TRUST_NO_CALL_AE
    end

    -- You can only summon trusts if you are the party leader or solo
    local leader = caster:getPartyLeader()
    if leader and caster:getID() ~= leader:getID() then
        caster:messageSystem(tpz.msg.system.TRUST_SOLO_OR_LEADER)
        return -1
    end

    -- Block summoning trusts if seeking a party
    if caster:isSeekingParty() then
        caster:messageSystem(tpz.msg.system.TRUST_NO_SEEKING_PARTY)
        return -1
    end

    -- Block summoning trusts if someone recently joined party (120s)
    local last_party_member_added_time = caster:getPartyLastMemberJoinedTime()
    if os.time() - last_party_member_added_time < 120 then
        caster:messageSystem(tpz.msg.system.TRUST_DELAY_NEW_PARTY_MEMBER)
        return -1
    end
    
    -- Trusts cannot be summoned if you have hate
    if caster:hasEnmity() then
        caster:messageSystem(tpz.msg.system.TRUST_NO_ENMITY)
        return -1
    end

    -- Check party for trusts
    local num_pt = 0
    local num_trusts = 0
    local party = caster:getPartyWithTrusts()
    for _, member in ipairs(party) do
        if member:getObjType() == tpz.objType.TRUST then
            -- Check for same trust
            if member:getTrustID() == spell:getID() then
                caster:messageSystem(tpz.msg.system.TRUST_ALREADY_CALLED)
                return -1
            -- Check not allowed trust combinations (Shantotto I vs Shantotto II)
            elseif type(not_allowed_trust_ids) == "number" then
                if member:getTrustID() == not_allowed_trust_ids then
                    caster:messageSystem(tpz.msg.system.TRUST_ALREADY_CALLED)
                    return -1
                end
            elseif type(not_allowed_trust_ids) == "table" then
                for _, v in pairs(not_allowed_trust_ids) do
                    if type(v) == "number" then
                        if member:getTrustID() == v then
                            caster:messageSystem(tpz.msg.system.TRUST_ALREADY_CALLED)
                            return -1
                        end
                    end
                end
            end
            num_trusts = num_trusts + 1
        end
        num_pt = num_pt + 1
    end

    -- Max party size
    if num_pt >= 6 then
        caster:messageSystem(tpz.msg.system.TRUST_MAXIMUM_NUMBER)
        return -1
    end

    -- Limits set by ROV Key Items
    if num_trusts >= 3 and not caster:hasKeyItem(tpz.ki.RHAPSODY_IN_WHITE) then
        caster:messageSystem(tpz.msg.system.TRUST_MAXIMUM_NUMBER)
        return -1
    elseif num_trusts >= 4 and not caster:hasKeyItem(tpz.ki.RHAPSODY_IN_CRIMSON) then
        caster:messageSystem(tpz.msg.system.TRUST_MAXIMUM_NUMBER)
        return -1
    end

    return 0
end

tpz.trust.spawn = function(caster, spell)
    caster:spawnTrust(spell:getID())

    return 0
end

tpz.trust.message = function(mob, message_offset)
    local master = mob:getMaster()
    local trust_offset = tpz.msg.system.GLOBAL_TRUST_OFFSET + (mob:getTrustID() - 896) * 100
    local party = master:getParty()

    for _, member in ipairs(party) do
        member:messageCombat(mob, trust_offset + message_offset, 0, 711)
    end
end

tpz.trust.teamworkMessage = function(mob, teamwork_messages)
    local messages = {}

    local master = mob:getMaster()
    local party = master:getPartyWithTrusts()
    for _, member in ipairs(party) do
        if member:getObjType() == tpz.objType.TRUST then
            for id, message in pairs(teamwork_messages) do
                if member:getTrustID() == id then
                    table.insert(messages, message)
                end
            end
        end
    end

    if table.getn(messages) > 0 then
        tpz.trust.message(mob, messages[math.random(#messages)])
    else
        -- Defaults to regular spawn message
        tpz.trust.message(mob, tpz.trust.message_offset.SPAWN)
    end
end

-- For debugging and lining up teamwork messages
tpz.trust.dumpMessages = function(mob)
    for i=0, 20 do
        tpz.trust.message(mob, i)
    end
end
