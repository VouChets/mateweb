<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests;
use App\Helpers\JwtAuth;
use App\Provincia;

use Exception;

class  ProvinciaController extends Controller
{
	public function store(Request $request)
	{
		try {
			$hash = $request->header('Authorization', null);
			$jwtAuth = new JwtAuth();
			$checkToken = $jwtAuth->checkToken($hash);
			if ($checkToken) {
				$params = $request;
				$user = $jwtAuth->checkToken($hash, true);
				$provincia = new Provincia();
				//	$provincia->user_id = $user->sub;
				if (isset($params->descripcion)) {
					$provincia->descripcion = $params->descripcion;
				}
				$provincia->save();
				return "ok";
				return response()->json($provincia, 201);
			} else {
				return response()->json(null, 401);
			}
		} catch (Exception $e) {
			return response()->json(null, 500);
		}
	}
	public function index(Request $request)
	{
		try {
			$hash = $request->header('Authorization', null);
			$jwtAuth = new JwtAuth();
			$checkToken = $jwtAuth->checkToken($hash);
			if ($checkToken) {
				$provincias = Provincia::all()->load('user');
				$provincias = Provincia::all();
				return $provincias->toJson(JSON_PRETTY_PRINT);
			} else {
				return response()->json(null, 401);
			}
		} catch (Exception $e) {
			return response()->json(null, 500);
		}
	}
	public function show(Request $request, $id)
	{
		try {
			$hash = $request->header('Authorization', null);
			$jwtAuth = new JwtAuth();
			$checkToken = $jwtAuth->checkToken($hash);
			if ($checkToken) {
				$provincia = Provincia::find($id);
				return $provincia;
			} else {
				return response()->json(null, 401);
			}
		} catch (Exception $e) {
			return response()->json(null, 500);
		}
	}
	public function destroy(Request $request, $idurl)
	{
		try {
			$hash = $request->header('Authorization', null);
			$jwtAuth = new JwtAuth();
			$checkToken = $jwtAuth->checkToken($hash);
			if ($checkToken) {
				$provincia = Provincia::find($idurl);
				if ($provincia == null) {
					return response()->json(null, 400);
				} else {
					Provincia::destroy($idurl);
					return response()->json(null, 200);
				}
			} else {
				return response()->json(null, 401);
			}
		} catch (Exception $e) {
			return response()->json(null, 500);
		}
	}
	public function update(Request $request, $idurl)
	{
		try {
			$hash = $request->header('Authorization', null);
			$jwtAuth = new JwtAuth();
			$checkToken = $jwtAuth->checkToken($hash);
			if ($checkToken) {
				$params = $request;
				$user = $jwtAuth->checkToken($hash, true);
				$id = $params->id;
				if ($idurl != $id) {
					return response()->json(null, 400);
				}
				Provincia::where('id', $id)
					->update([
						'user_id' => $user->sub,
						'descripcion' => $params->descripcion,
					]);
				$provincia = Provincia::find($id);
				return response()->json($provincia, 200);
			} else {
				return response()->json(null, 401);
			}
		} catch (Exception $e) {
			return response()->json(null, 500);
		}
	}
}
