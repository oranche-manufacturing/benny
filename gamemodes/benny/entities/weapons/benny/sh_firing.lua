
function SWEP:CallFire()
	local class = self:BClass( false )
	local spread = class.Spread or 0
	for i=1, class.Pellets or 1 do
		local dir = self:GetOwner():EyeAngles()

		local radius = util.SharedRandom("benny_distance", 0, 1, i )
		local circ = util.SharedRandom("benny_radius", 0, math.rad(360), i )

		dir:RotateAroundAxis( dir:Right(), spread * radius * math.sin( circ ) )
		dir:RotateAroundAxis( dir:Up(), spread * radius * math.cos( circ ) )
		dir:RotateAroundAxis( dir:Forward(), 0 )
		local tr = util.TraceLine( {
			start = self:GetOwner():EyePos(),
			endpos = self:GetOwner():EyePos() + dir:Forward() * 8192,
			filter = self:GetOwner()
		} )

		self:FireBullets( {
			Attacker = self:GetOwner(),
			Damage = self:BClass( false ).Damage,
			Force = self:BClass( false ).Damage/10,
			Src = self:GetOwner():EyePos(),
			Dir = dir:Forward(),
			IgnoreEntity = self:GetOwner(),
			Callback = self.BulletCallback,
		} )

		-- self:FireCL( tr )
		-- self:FireSV( tr )
	end
end

function SWEP:BulletCallback()
	return true
end



function SWEP:FireCL( tr )
	if CLIENT and IsFirstTimePredicted() then
		do
			local vStart = self.CWM:GetAttachment( 1 ).Pos
			local vPoint = tr.HitPos
			local effectdata = EffectData()
			effectdata:SetStart( vStart )
			effectdata:SetOrigin( vPoint )
			effectdata:SetEntity( self )
			effectdata:SetScale( 1025*12 )
			effectdata:SetFlags( 1 )
			util.Effect( "Tracer", effectdata )
		end
		-- util.DecalEx( Material( util.DecalMaterial( "Impact.Concrete" ) ), tr.Entity, tr.HitPos, tr.HitNormal, color_white, 1, 1 )
		do
			local effectdata = EffectData()
			effectdata:SetOrigin( tr.HitPos )
			effectdata:SetStart( tr.StartPos )
			effectdata:SetSurfaceProp( tr.SurfaceProps )
			effectdata:SetEntity( tr.Entity )
			effectdata:SetDamageType( DMG_BULLET )
			util.Effect( "Impact", effectdata )
		end
	end
end

function SWEP:FireSV( tr )
	local class = self:BClass( false )
	if SERVER and IsValid( tr.Entity ) then
		local dmginfo = DamageInfo()
		dmginfo:SetDamage( class.Damage )
		dmginfo:SetAttacker( self:GetOwner() )
		dmginfo:SetInflictor( self )
		dmginfo:SetDamageType( DMG_BULLET )
		dmginfo:SetDamagePosition( tr.HitPos )
		tr.Entity:TakeDamageInfo( dmginfo )
	end
end