//
//  AppViewController.swift
//  Filmes Teste
//
//  Created by Francisco Neto on 05/06/22.
//

import UIKit
import FirebaseAuth
import SideMenu
class AppViewController: UIViewController, MenuControllerDelegate{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    @IBOutlet weak var tableView: UITableView!
    private var sideMenu: SideMenuNavigationController?
    var movieManager = MovieManager()
    var movies: [Movies] = []
    var i = 0
    var imagemFilmes: [UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        movieManager.delegate = self
        title = "Filmes mais populares"
        let menu = MenuController(with: SideMenuItem.allCases)
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FilmeCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        movieManager.fetchData(link: "https://imdb-api.com/en/API/MostPopularMovies/")
    }

    @IBAction func didTapMenuButton() {
        present(sideMenu!, animated: true)
    }

    func didSelectMenuItem(named: SideMenuItem) {
        sideMenu?.dismiss(animated: true, completion: nil)
        title = named.rawValue
        switch named {
        case .filmesPop:
            movieManager.fetchData(link: "https://imdb-api.com/en/API/MostPopularMovies/")
        case .seriesPop:
            movieManager.fetchData(link: "https://imdb-api.com/en/API/MostPopularTVs/")
        case .logout:
            do {
                try Auth.auth().signOut()
                navigationController?.popToRootViewController(animated: true)
                
            } catch let signOutError as NSError {
              print ("Error signing out: %@", signOutError)
            }
        }

    }
}

extension AppViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! FilmeCell
        cell.labelNomeFilme.text = movies[indexPath.row].fullTitle
        cell.labelNotaImdb.text = "Nota: \(movies[indexPath.row].imDbRating)"
        cell.labelUpDown.text = movies[indexPath.row].rankUpDown
        cell.labelRank.text = "Rank: \(movies[indexPath.row].rank)"
        let myIntegerVariable = (movies[indexPath.row].rankUpDown as NSString) .integerValue
        if (myIntegerVariable > 0){
            cell.labelUpDown.textColor = .green
            cell.arrow.image = UIImage(systemName: "arrowtriangle.up.fill")
        }else{
            if (myIntegerVariable == 0){
                cell.labelUpDown.textColor = .black
                cell.arrow.image = UIImage(systemName: "arrowtriangle.right.fill")
            }else{
                cell.labelUpDown.textColor = .red
                cell.arrow.image = UIImage(systemName: "arrowtriangle.down.fill")
            }
        }
        if let url = URL(string: movies[indexPath.row].image) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }

                DispatchQueue.main.async { /// execute on main thread
                    cell.imageFilme.image = UIImage(data: data)
                }
            }

            task.resume()
        }
        return cell
    }
}
extension AppViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
extension AppViewController: MovieManagerDelegate{
    func didUpdateMovie(_ movieManager: MovieManager, movie: MovieModel) {
        DispatchQueue.main.async {
            self.movies = movie.itens
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
