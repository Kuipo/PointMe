local ADDON_NAME = "PointMe"
local COMMS_PREFIX = "PointMeEvents"

--- @class PointMe
local PointMe = {}

PointMe = LibStub("AceAddon-3.0"):NewAddon(ADDON_NAME, "AceEvent-3.0", "AceComm-3.0", "AceSerializer-3.0")

function PointMe:OnInitialize()
    self:RegisterEvents()
    self:RegisterCommunication()
end

function PointMe:RegisterCommunication()
    self:RegisterComm(COMMS_PREFIX, "CommReceived");
end

--- Processes comm messages recieved from AceComm
-- @param prefix String classification of the message, COMMS_PREFIX
-- @param message Data recieved, serialized
-- @param distribution Addon channel, "PARTY"
-- @param sender Character name of the user that sent the message
function PointMe:CommReceived(prefix, message, distribution, sender)
    if sender ~= UnitName("player") then
        print("  Message from other");
        local success, PinData = self:Deserialize(message);
        self:SetMapPin(PinData);
    else
        print("  Message from self, skipping");
    end
end

function PointMe:RegisterEvents()
    self:RegisterEvent("USER_WAYPOINT_UPDATED", "OnMapPinChanged");
end

--- Sets a map pin at a specific point
-- @param newPinData UiMapPoint object to set
function PointMe:SetMapPin(newPinData)
    if C_Map.HasUserWaypoint() == true then
        -- print('User has pin, checking it');
        local curPinData = C_Map.GetUserWaypoint();
        if curPinData.uiMapID == newPinData.uiMapID and curPinData.position.x == newPinData.position.x and curPinData.position.y == newPinData.position.y then
            -- print('New pin and old pin match, stopping.');
        else
            -- print('Setting new pin');
            C_Map.SetUserWaypoint(newPinData);
        end
    else
        -- print('No pin detected, setting new pin');
        C_Map.SetUserWaypoint(newPinData);
    end
end

--- Used to autotrack the waypoint after being set
function PointMe:TrackWaypoint()
    C_SuperTrack.SetSuperTrackedUserWaypoint(true);
end

function PointMe:SendPinToComms()
    local pinData = C_Map.GetUserWaypoint();
    local serializedPinData = self:Serialize(pinData);
    self:SendCommMessage(COMMS_PREFIX, serializedPinData, "PARTY");
end

function PointMe:OnMapPinChanged()
    if IsInGroup() then
        if C_Map.HasUserWaypoint() == true then
            RunNextFrame(function() self:TrackWaypoint() end);
            self:SendPinToComms();
        end
    end
end

PointMe:OnInitialize()

return PointMe
