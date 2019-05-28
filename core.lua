local GTT = GameTooltip;
local GuildInfo = {};

GTT:HookScript("OnTooltipSetUnit",function(self,...)
	local _, unit = self:GetUnit();
	if (not unit) then
		local mFocus = GetMouseFocus();
		if (mFocus) and (mFocus.unit) then
			unit = mFocus.unit;
		end
	end
	DoScan()
	
	if (UnitIsPlayer(unit)) then
		if GuildInfo[UnitName(unit)] then
			self:AddLine("Rank: |cFFFFFFFF" .. GuildInfo[UnitName(unit)].rank .. "|r");
			self:AddLine("Note: |cFFFFFFFF" .. GuildInfo[UnitName(unit)].note .. "|r");

			if EPGP then
				local ep, gp, main = EPGP:GetEPGP(UnitName(unit));
				main = main or UnitName(unit)
				if ep and gp and main then
					self:AddLine("EPGP: |cFFFFFFFF" .. main .. "->".. ep .. ", " .. gp .. ", " .. round(ep/gp, 2)  .. "|r");
				end
			else
				self:AddLine("EPGP: |cFFFFFFFF" .. GuildInfo[name].EPGP .. "|r");
			end
		end
	end
end);

function DoScan() 
	for i = 1, GetNumGuildMembers() do 
	   local name, rank, _, _, _, _, note, officernote = GetGuildRosterInfo(i); 
	   GuildInfo[name] = {};
	   GuildInfo[name].rank = rank;
	   GuildInfo[name].note = note;
	   GuildInfo[name].EPGP = officernote;
	end
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
 end