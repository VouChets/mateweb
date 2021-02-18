<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests;
use App\User;
use Illuminate\Support\Facades\DB;
use App\Helpers\JwtAuth;

class UserController extends Controller {

    public function register(Request $request) {
        $params =  $request;
        $email = (isset($params->email)) ? $params->email : null;
        $name = (isset($params->name)) ? $params->name : null;
        $password = (isset($params->password)) ? $params->password : null;
        //return $request->name;
        if (!is_null($email) && !is_null($password) && !is_null($name)) {
            //crear el usuario
            $user = new User();
            $user->email = $email;
            $user->name = $name;
            $pwd = hash('sha256', $password);
            $user->password = $pwd;
            $user->idrol=1;
            $user->activo=$params->activo;
            $user->google=0;
            $isset_user = User::where('email', '=', $email)->first();
            if (count($isset_user) == 0) {
                $user->save();
                $data = array(
                    'status' => 'success',
                    'code' => 200,
                    'message' => 'Usuario creado'
                );
            } else {
                $data = array(
                    'status' => 'error',
                    'code' => 400,
                    'message' => 'Usuario duplicado, no puede registrarse'
                );
            }
        } else {
            $data = array(
                'status' => 'error',
                'code' => 400,
                'message' => 'Usuario no creado '
            );
        }
        return response()->json($data, 200);
    }

    public function login(Request $request) {
        $jwtAuth = new JwtAuth();
        $params = $request;
        $email = (isset($params->email)) ? $params->email : null;
        $password = (isset($params->password)) ? $params->password : null;
        $getToken = (isset($params->getToken)) ? $params->getToken : true;
        $pwd = hash('sha256', $password);
        if (!is_null($email) && !is_null($password) && ($getToken == null || $getToken == 'false')) {
            $signup = $jwtAuth->singup($email, $pwd);
        } elseif ($getToken != null) {
            $signup = $jwtAuth->singup($email, $pwd, $getToken);
        } else {
            $signup = array(
                'status' => 'error',
                'message' => 'Envia tus datos por post.'
            );
        }
        return response()->json($signup, 200);
    }

    public function index() {
        $users = User::all();
        $usersDTO = [];
        foreach ($users as $u) {
            //$uDTO->name=$u->name;
            $uDTO = (object) array('id' => $u->id, 'name' => $u->name, 'email' => $u->email);
            array_push($usersDTO, $uDTO);
        }
        return response()->json(array(
                    'items' => $usersDTO,
                    'status' => 200
                        ), 200);
    }

    public function update(Request $request) {
        $hash = $request->header('Authotization', null);
        $jwtAuth = new JwtAuth();
        $checkToken = $jwtAuth->checkToken($hash);
        if ($checkToken) {
            $json = $request->input('json', null);
            $params = json_decode($json);
            $user = $jwtAuth->checkToken($hash, true);
            $id = $params->id;
            if (isset($params->password)) {
                $pwd = hash('sha256', $params->password);
                User::where('id', $id)
                        ->update([
                            'email' => $params->email,
                            'name' => $params->name,
                            'password' => $pwd
                ]);
            } else {
                User::where('id', $id)
                        ->update([
                            'email' => $params->email,
                            'name' => $params->name
                ]);
            }
            $user = User::where('id', $id);
            $data = array(
                'user' => $user,
                'status' => 'success',
                'code' => 200
            );
        } else {
            $data = array(
                'message' => 'Login incorrecto',
                'status' => 'error',
                'code' => 300
            );
        }
        return response()->json($data, 200);
    }

}
