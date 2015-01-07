sessionUtils = {}

sessionUtils.getAuthTokenIdFromReq = (req) ->
	# Get session id from cookie
	return req.cookies['_authTokenId'] or req.cookies['authTokenId']

sessionUtils.getSessionFromReq = (req) ->
	# Get session id from cookie
	sessionId = req.cookies['_authTokenId'] or req.cookies['authTokenId']

	# If no session id was found return error
	if not _.isString sessionId
		return new Error 'Session doesn\'t exists'

	# Find all session info into active sessions using id from cookie
	session = Models.ActiveSessions.findOne _id: new Meteor.Collection.ObjectID sessionId

	# If no session was found return error
	if not session?
		return new Error 'Session doesn\'t exists'

	return session

sessionUtils.getSessionFromMethod = (request) ->
	# Get session id from cookie
	sessionId = request.authTokenId

	# If no session id was found return error
	if not _.isString sessionId
		return new Error 'Session doesn\'t exists'

	# Find all session info into active sessions using id from cookie
	session = Models.ActiveSessions.findOne _id: new Meteor.Collection.ObjectID sessionId

	# If no session was found return error
	if not session?
		return new Error 'Session doesn\'t exists'

	return session

sessionUtils.deleteSession = (session) ->
	Models.ActiveSessions.remove _id: session

sessionUtils.refreshSession = (session, user) ->
	# Define new expiration based on user config or use 6h as default
	if user.sessionExpireAfterMinutes?
		sessionExpireAfterMinutes = user.sessionExpireAfterMinutes
	else
		sessionExpireAfterMinutes = 360

	sessionExpireAt = new Date
	sessionExpireAt = new Date sessionExpireAt.setMinutes sessionExpireAt.getMinutes() + sessionExpireAfterMinutes

	# Define query and update to set new expiration value
	query =
		_id: session._id

	update =
		$set:
			expireAt: sessionExpireAt

	Models.ActiveSessions.update query, update
