/**
 * Create a Promise-like struct with next/error functions.
 * Callbacks execution (success/error) have to be externally handled, pratically calling promise.execSuccess() and promise.execError()
 * Reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise
 *
 * @author Emmanuel Di Iorio (aka "Xeryan")
 * @version 0.0.1-alpha
 * @license MIT
 *
 * @param {Function} executor The function that will be exeduted after the promise initialization
 * @param {Any} [context] Any data that may be stored inside the struct for later usage (optional)
 * 
 * @return {Struct<Promise>}
 */
function Promise(executor, _context = undefined) constructor {
	context = _context;
	__success_callbacks = [];
	__error_callbacks = [];
	
	/**
	 * This is the main method, used to recursively call the first callback in the promise list.
	 * Also, when a callback returns a promise, it will add an interceptor to inject its response into the parent promise first callback
	 */
	__exec = function(array, resp) {
		// When a callback returns a Struct<Promise>, add an interceptor in the original promise in order to inject the response into this parent promise
		if (is_struct(resp) && instanceof(resp) == "Promise") {
			var closure = { 
				__exec: __exec,
				__success_callbacks: __success_callbacks,
				__error_callbacks: __error_callbacks				
			};
			resp.next(method(closure, function(childResp) {
				__exec(__success_callbacks, childResp);
			}));
			resp.error(method(closure, function(childErr) {
				__exec(__error_callbacks, childErr);
			}));
			var injectedCallback = function(resp) { 
				return resp; 
			};
			array_insert(__success_callbacks, 0, injectedCallback);
			array_insert(__error_callbacks, 0, injectedCallback);
		}
			
		// Execute the first callback in the list
		if (!array_length(array)) return;
		var callback = array[0];
		array_delete(array, 0, 1);
		callback(resp);
	};
	
	execSuccess = function(resp) {
		__exec(__success_callbacks, resp);
	};
	
	execError = function(resp) {
		__exec(__error_callbacks, resp);
	};
	
	/**
	 * Add a success callback to the list
	 */
	next = function(func) {
		var closure = {
			func: func,
			__exec: __exec,
			__success_callbacks: __success_callbacks,
			__error_callbacks: __error_callbacks
		};
		
		array_push(__success_callbacks, method(closure, function(resp) {
			__exec(__success_callbacks, func(resp));
		}));
		
		return self;
	};
	
	/**
	 * Add an error callback to the list
	 */
	error = function(func) {
		var closure = {
			func: func,
			__exec: __exec,
			__success_callbacks: __success_callbacks,
			__error_callbacks: __error_callbacks
		};
		
		array_push(__error_callbacks, method(closure, function(err) {
			__exec(__error_callbacks, func(err));
		}));
		
		return self;
	};
	
	// Simplified callback pattern
	// Example: function(err, resp) {}
	addCallback = function(callback) {
		var closure = { callback: callback };
		self.next(method(closure, function(resp) { callback(undefined, resp); }));
		self.error(method(closure, function(err) { callback(err); }));
	}
	
	executor(self);
}